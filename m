Received: from eggs.gnu.org ([2001:4830:134:3::10]:56695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJZb-0002IZ-9O
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJZV-0007wV-MD
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:32:27 -0400
References: <20170919102434.21147-1-pbonzini@redhat.com>
	<20170919102434.21147-5-pbonzini@redhat.com>
	<20170919125300.GL9536@redhat.com>
	<d80b9409-9524-4a05-d0a3-d3e8f23c416b@redhat.com>
	<20170919131208.GM9536@redhat.com>
	<ddc23258-0e68-f2e3-72a3-c16e443a7143@redhat.com>
	<20170919132627.GN9536@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c01b9beb-7f85-32ed-2958-f1a688ba3478@redhat.com>
Date: Tue, 19 Sep 2017 16:32:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170919132627.GN9536@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] scsi: add persistent reservation
 manager using qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 19/09/2017 15:26, Daniel P. Berrange wrote:
> On Tue, Sep 19, 2017 at 03:23:09PM +0200, Paolo Bonzini wrote:
>> On 19/09/2017 15:12, Daniel P. Berrange wrote:
>>> On Tue, Sep 19, 2017 at 02:57:00PM +0200, Paolo Bonzini wrote:
>>>> On 19/09/2017 14:53, Daniel P. Berrange wrote:
>>>>>> +    /* Try to reconnect while sending the CDB.  */
>>>>>> +    for (attempts = 0; attempts < PR_MAX_RECONNECT_ATTEMPTS; attempts++) {
>>>>>
>>>>> I'm curious why you need to loop here. The helper daemon should be running
>>>>> already, as you're not spawning it on demand IIUC. So it shoudl either
>>>>> succeed first time, or fail every time.
>>>>
>>>> You're focusing on the usecase where the helper daemon is spawned per-VM
>>>> by the system libvirtd, which I agree is the most important one.
>>>> However, the other usecase is the one with a global daemon, access to
>>>> which is controlled via Unix permissions.  This is not SELinux-friendly,
>>>> but it is nicer for testing and it is also the only possibility for user
>>>> libvirtd.
>>>>
>>>> In that case, upgrading QEMU on the host could result in a "systemctl
>>>> restart qemu-pr-helper.service" (or, hopefully unlikely, a crash could
>>>> result in systemd respawning the daemon).  Reconnect is useful in that case.
>>>
>>> If using systemd socket activation and you restart the daemon, the listening
>>> socket should be preserved, so you shouldn't need to reconnect - the client
>>> should get queued until it has started again (likewise on crash).
>>
>> Oh, that's cool.  I didn't know that.  However, systemd socket
>> activation is optional, and it's only a handful of lines so I think it's
>> a bit nicer behavior (chardevs for example have options to reconnect).
> 
> The downside is that if someone forget to start the daemon, or enable
> the socket,  QEMU will spin for 5 seconds trying to reconnect, instead
> of reporting an error immediately. 

Not exactly:

- the daemon must be present at startup.  Reconnect is only tried when
sending a command.

- it's not a busy wait, pr_manager_helper_run runs in an
util/thread-pool.c worker thread (see pr_manager_execute in patch 1).

Paolo
