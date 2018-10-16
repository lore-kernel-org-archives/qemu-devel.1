Received: from eggs.gnu.org ([2001:4830:134:3::10]:56443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCGeV-0004TL-Ng
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 00:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCGeS-00061T-E9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 00:08:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCGeS-0005zN-2X
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 00:08:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-28-armbru@redhat.com>
	<2fe22e4c-d7b8-f41e-493c-ffd8b7169e44@suse.com>
Date: Tue, 16 Oct 2018 06:08:05 +0200
In-Reply-To: <2fe22e4c-d7b8-f41e-493c-ffd8b7169e44@suse.com> (Fei Li's message
	of "Mon, 15 Oct 2018 20:51:31 +0800")
Message-ID: <87woqiv8ii.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 27/35] vnc: Clean up error reporting in
 vnc_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Fei Li <fli@suse.com> writes:

> On 10/15/2018 07:53 PM, Markus Armbruster wrote:
>> Calling error_report() in a function that takes an Error ** argument
>> is suspicious.  vnc_init_func() does that, and then fails without
>> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
>> with it, but clean it up anyway.
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   ui/vnc.c | 9 +++++----
>>   vl.c     | 2 +-
>>   2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 98e3d3b1d8..fcd2744d52 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -4082,13 +4082,14 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>>       assert(id);
>>       vnc_display_init(id, &local_err);
>>       if (local_err) {
>> -        error_report_err(local_err);
>> -        exit(1);
>> +        error_propagate(errp, local_err);
> Shall we use error_propagate(errp, local_err, ("Failed to init VNC
> server: ");
> like vnc_display_open does?

I don't know.  

The error reporting is somewhat poor around here.  Consider:

    $ qemu-system-x86_64 -display vnc=:0,share=nope
    qemu-system-x86_64: -display vnc=:0,share=nope: Failed to start VNC server: unknown vnc share= option

The "Failed to start VNC server: " prefix doesn't really add value.

    $ qemu-system-x86_64 -display vnc=:0 -k bad
    qemu-system-x86_64: -display vnc=:0: could not read keymap file: 'bad'

The error message refers to -display instead of -k.  I doubt adding the
prefix would improve it.

Gerd, what do you think?

> If yes, I guess this error message should be added from last patch [26/35].

Yes.

> If not, please omit. :)
>
> Have a nice day
> Fei
>> +        return -1;
>>       }
>>       vnc_display_open(id, &local_err);
>>       if (local_err != NULL) {
>> -        error_reportf_err(local_err, "Failed to start VNC server: ");
>> -        exit(1);
>> +        error_propagate_prepend(errp, local_err,
>> +                                "Failed to start VNC server: ");
>> +        return -1;
>>       }
>>       return 0;
>>   }
>> diff --git a/vl.c b/vl.c
>> index c053117028..8e0006d49c 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4526,7 +4526,7 @@ int main(int argc, char **argv, char **envp)
>>       /* init remote displays */
>>   #ifdef CONFIG_VNC
>>       qemu_opts_foreach(qemu_find_opts("vnc"),
>> -                      vnc_init_func, NULL, NULL);
>> +                      vnc_init_func, NULL, &error_fatal);
>>   #endif
>>         if (using_spice) {
