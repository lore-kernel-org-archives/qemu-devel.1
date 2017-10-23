Received: from eggs.gnu.org ([2001:4830:134:3::10]:43550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=462d8fd40=ross.lagerwall@citrix.com>)
	id 1e6dkD-00014N-5H
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=462d8fd40=ross.lagerwall@citrix.com>)
	id 1e6dk9-0005pZ-Vw
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:30:21 -0400
Received: from smtp.citrix.com ([66.165.176.89]:36860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=462d8fd40=ross.lagerwall@citrix.com>)
	id 1e6dk9-0005oa-HN
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:30:17 -0400
References: <20171019160419.11611-1-ross.lagerwall@citrix.com>
	<20171019162420.GA8408@redhat.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <2c1c1652-7a70-7330-98b2-9225b35670a8@citrix.com>
Date: Mon, 23 Oct 2017 15:30:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171019162420.GA8408@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] os-posix: Add -unshare option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 10/19/2017 05:24 PM, Daniel P. Berrange wrote:
> On Thu, Oct 19, 2017 at 05:04:19PM +0100, Ross Lagerwall wrote:
>> Add an option to allow calling unshare() just before starting guest
>> execution. The option allows unsharing one or more of the mount
>> namespace, the network namespace, and the IPC namespace. This is useful
>> to restrict the ability of QEMU to cause damage to the system should it
>> be compromised.
>>
>> An example of using this would be to have QEMU open a QMP socket at
>> startup and unshare the network namespace. The instance of QEMU could
>> still be controlled by the QMP socket since that belongs in the original
>> namespace, but if QEMU were compromised it wouldn't be able to open any
>> new connections, even to other processes on the same machine.
> 
> Unless I'm misunderstanding you, what's described here is already possible
> by just using the 'unshare' command to spawn QEMU:
> 
>    # unshare --ipc --mount --net qemu-system-x86_64 -qmp unix:/tmp/foo,server -vnc :1
>    qemu-system-x86_64: -qmp unix:/tmp/foo,server: QEMU waiting for connection on: disconnected:unix:/tmp/foo,server
> 
> And in another shell I can still access the QMP socket from the original host
> namespace

So that works because UNIX domains sockets are not restricted by network 
namespaces. But if you try to connect to the VNC server listening on TCP 
port 5901, it won't work.

> 
>    # ./scripts/qmp/qmp-shell /tmp/foo
>    Welcome to the QMP low-level shell!
>    Connected to QEMU 2.9.1
> 
>    (QEMU) query-kvm
>    {"return": {"enabled": false, "present": true}}
> 
> 
> FWIW, even if that were not possible, you could still do it by wrapping the
> qmp-shell in an 'nsenter' call. eg
> 
>    nsenter --target $QEMUPID --net ./scripts/qmp/qmp-shell /tmp/foo

I have a single process which connects to all the QEMUs' listening VNC 
sockets so I'm not sure that this would work.

> 
>> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
>> ---
>>   os-posix.c      | 34 ++++++++++++++++++++++++++++++++++
>>   qemu-options.hx | 14 ++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/os-posix.c b/os-posix.c
>> index b9c2343..cfc5c38 100644
>> --- a/os-posix.c
>> +++ b/os-posix.c
>> @@ -45,6 +45,7 @@ static struct passwd *user_pwd;
>>   static const char *chroot_dir;
>>   static int daemonize;
>>   static int daemon_pipe;
>> +static int unshare_flags;
>>   
>>   void os_setup_early_signal_handling(void)
>>   {
>> @@ -160,6 +161,28 @@ void os_parse_cmd_args(int index, const char *optarg)
>>           fips_set_state(true);
>>           break;
>>   #endif
>> +#ifdef CONFIG_SETNS
>> +    case QEMU_OPTION_unshare:
>> +        {
>> +            char *flag;
>> +            char *opts = g_strdup(optarg);
>> +
>> +            while ((flag = qemu_strsep(&opts, ",")) != NULL) {
>> +                if (!strcmp(flag, "mount")) {
>> +                    unshare_flags |= CLONE_NEWNS;
>> +                } else if (!strcmp(flag, "net")) {
>> +                    unshare_flags |= CLONE_NEWNET;
>> +                } else if (!strcmp(flag, "ipc")) {
>> +                    unshare_flags |= CLONE_NEWIPC;
>> +                } else {
>> +                    fprintf(stderr, "Unknown unshare option: %s\n", flag);
>> +                    exit(1);
>> +                }
>> +            }
>> +            g_free(opts);
>> +        }
>> +        break;
>> +#endif
>>       }
>>   }
>>   
>> @@ -201,6 +224,16 @@ static void change_root(void)
>>   
>>   }
>>   
>> +static void unshare_namespaces(void)
>> +{
>> +    if (unshare_flags) {
>> +        if (unshare(unshare_flags) < 0) {
>> +            perror("could not unshare");
>> +            exit(1);
>> +        }
>> +    }
>> +}
>> +
>>   void os_daemonize(void)
>>   {
>>       if (daemonize) {
>> @@ -266,6 +299,7 @@ void os_setup_post(void)
>>       }
>>   
>>       change_root();
>> +    unshare_namespaces();
>>       change_process_uid();
> 
> This has some really bad implications.  All the command line options that are
> given are processed *beforfe* os_setup_post() is called. IOW, -chardev, -vnc,
> -migrate, -net, etc will all be configured in the context of the host namespace.
> 
> If you then use the QMP monitor to run  chardev_add,  device_add, migrate,
> hostnet_add, etc this will all take place in the new namespace.
> 
> So the exact same args give as ARGV now have completely different semantics
> when given via QMP.
> 
> I think this is really very undesirable.

I consider this to be broadly similar to using -chroot -- adding devices 
and so on after chrooting would have a different effect compared with 
adding them after chrooting. I do agree though that both -chroot and 
-unshare could have confusing semantics.

> 
> If you wrap QEMU execution in 'unshare' as I illustrate above, then the
> semantics of ARGV & QMP remain consistent.
> 
> FWIW, as a further point that might be of interest, libvirt will now spawn
> a new private mount namespace for QEMU by default. We do this so that we can
> give QEMU a private /dev filesystem with only the devices its permitted to
> use present as device nodes.  The ability to do such setup tasks inbetween
> namespace creation and QEMU launching is broadly useful. For example, if
> using a private network namespace, you might want to create a veth pair and
> put one end in the namespace, so that QEMU's network services have some
> level of outside network connectivity - eg to enable QEMU to connect to a remote
> QEMU for live migration.

Hmm, I think having a veth pair per VM might be a little too much 
overhead and management just to expose the VNC port.

> 
> So overall, I absolutely encourage the use of namespaces to confine QEMU,
> but I tend to think namespace creation/setup is better done outside QEMU
> before launching it.
> 

Thanks for the extensive comments. While I do think that there is some 
value in being able to unshare namespaces after doing the initial setup 
(much like chrooting and dropping privileges), I think for now I can 
work around this by unsharing before starting QEMU and then ensuring 
that QEMU only listens on UNIX domain sockets rather than TCP sockets.

Regards,
-- 
Ross Lagerwall
