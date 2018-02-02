Received: from eggs.gnu.org ([2001:4830:134:3::10]:44759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehOxQ-0001m8-69
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehOvp-00009w-90
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:11:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehOvo-00005b-Mp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:10:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EF984F1B2
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 00:10:15 +0000 (UTC)
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-18-git-send-email-pbonzini@redhat.com>
	<20180201170004.7287d079@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6affcea1-a56b-f518-8b4b-a196d5401e33@redhat.com>
Date: Thu, 1 Feb 2018 19:10:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180201170004.7287d079@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 17/51] readline: add a free function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/02/2018 19:00, Alex Williamson wrote:
> On Tue, 16 Jan 2018 15:16:59 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Fixes leaks such as:
>>
>> Direct leak of 2 byte(s) in 1 object(s) allocated from:
>>     #0 0x7eff58beb850 in malloc (/lib64/libasan.so.4+0xde850)
>>     #1 0x7eff57942f0c in g_malloc ../glib/gmem.c:94
>>     #2 0x7eff579431cf in g_malloc_n ../glib/gmem.c:331
>>     #3 0x7eff5795f6eb in g_strdup ../glib/gstrfuncs.c:363
>>     #4 0x55db720f1d46 in readline_hist_add /home/elmarco/src/qq/util/r=
eadline.c:258
>>     #5 0x55db720f2d34 in readline_handle_byte /home/elmarco/src/qq/uti=
l/readline.c:387
>>     #6 0x55db71539d00 in monitor_read /home/elmarco/src/qq/monitor.c:3=
896
>>     #7 0x55db71f9be35 in qemu_chr_be_write_impl /home/elmarco/src/qq/c=
hardev/char.c:167
>>     #8 0x55db71f9bed3 in qemu_chr_be_write /home/elmarco/src/qq/charde=
v/char.c:179
>>     #9 0x55db71fa013c in fd_chr_read /home/elmarco/src/qq/chardev/char=
-fd.c:66
>>     #10 0x55db71fe18a8 in qio_channel_fd_source_dispatch /home/elmarco=
/src/qq/io/channel-watch.c:84
>>     #11 0x7eff5793a90b in g_main_dispatch ../glib/gmain.c:3182
>>     #12 0x7eff5793b7ac in g_main_context_dispatch ../glib/gmain.c:3847
>>     #13 0x55db720af3bd in glib_pollfds_poll /home/elmarco/src/qq/util/=
main-loop.c:214
>>     #14 0x55db720af505 in os_host_main_loop_wait /home/elmarco/src/qq/=
util/main-loop.c:261
>>     #15 0x55db720af6d6 in main_loop_wait /home/elmarco/src/qq/util/mai=
n-loop.c:515
>>     #16 0x55db7184e0de in main_loop /home/elmarco/src/qq/vl.c:1995
>>     #17 0x55db7185e956 in main /home/elmarco/src/qq/vl.c:4914
>>     #18 0x7eff4ea17039 in __libc_start_main (/lib64/libc.so.6+0x21039)
>>
>> (while at it, use g_new0(ReadLineState), it's a bit easier to read)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Message-Id: <20180104160523.22995-11-marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>=20
> I'm having some trouble with this patch, using b05631954d6d:
>=20
> # /usr/local/bin/qemu-system-x86_64 -m 1G -nodefaults -net none -monito=
r stdio -serial none -parallel none -nographic=20
> QEMU 2.11.50 monitor - type 'help' for more information
> (qemu) sys<tab>
> system_powerdown  system_reset      system_wakeup    =20
> (qemu) system_p<tab>    # resulting in system_powerdown
> (qemu) quit
> Segmentation fault (core dumped)
>=20
> gdb shows:
>=20
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x00007f7d64d82927 in malloc () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007f7d64d82927 in malloc () at /lib64/libc.so.6
> #1  0x00007f7d6ef68359 in g_malloc () at /lib64/libglib-2.0.so.0
> #2  0x00007f7d6ef83004 in g_strsplit () at /lib64/libglib-2.0.so.0
> #3  0x000055e5ac0d549d in container_get (root=3D0x55e5ad570ee0, path=3D=
path@entry=3D0x55e5ac2fa0f8 "/chardevs") at qom/container.c:34
> #4  0x000055e5ac14d102 in get_chardevs_root () at chardev/char.c:43
> #5  0x000055e5ac14ec4d in qemu_chr_cleanup () at chardev/char.c:1107
> #6  0x000055e5abeff1c4 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:4780
>=20
> Reverting this patch, commit e5dc1a6c6c435, I don't see the issue.
> Thanks,

Yeah, I have a fix queued.  Unfortunately, I don't have the usual setup
to do pre-pull-request sets here so it will have to wait for next Monday.

Paolo
