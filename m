Received: from eggs.gnu.org ([2001:4830:134:3::10]:57637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dMrKo-0006ix-EX
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dMrKl-0003ol-9n
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:42:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
	<55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
	<CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
	<6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
	<cdc49669-c996-b84d-8110-b7b62ada8ad0@gmx.com>
	<87lgoz98mc.fsf@dusky.pond.sub.org>
	<03bf9574-79a4-0778-bb6d-e0a6da7d1d86@gmx.com>
Date: Mon, 19 Jun 2017 09:42:45 +0200
In-Reply-To: <03bf9574-79a4-0778-bb6d-e0a6da7d1d86@gmx.com> (Kamil
	Rytarowski's message of "Sat, 10 Jun 2017 17:24:28 +0200")
Message-ID: <87poe0qv7u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] ivshmem-server:
 ivshmem-client: Build when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>

Kamil Rytarowski <n54@gmx.com> writes:

> On 10.06.2017 17:15, Markus Armbruster wrote:
>> Kamil Rytarowski <n54@gmx.com> writes:
>> 
>>> On 06.06.2017 16:56, Kamil Rytarowski wrote:
>>>> On 06.06.2017 16:34, Peter Maydell wrote:
>>>>> On 6 June 2017 at 14:38, Kamil Rytarowski <n54@gmx.com> wrote:
>>>>>> I've linked qemu with the original patch and:
>>>>>> ./configure --disable-linux-user --disable-system --static
>>>>>>
>>>>>> I got some warnings, I think they are originated from our libc and are
>>>>>> not related to qemu:
>>>>>>   LINK    sparc64-bsd-user/qemu-sparc64
>>>>>> /usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
>>>>>> overridden by definition
>>>>>> /usr/lib/crt0.o: warning: defined here
>>>>>> /usr/lib/libc.a(_env.o): warning: multiple common of `environ'
>>>>>> /usr/lib/crt0.o: warning: previous common is here
>>>>>> /usr/lib/libc.a(getprogname.o): warning: common of `__progname'
>>>>>> overridden by definition
>>>>>> /usr/lib/crt0.o: warning: defined here
>>>>>
>>>>> Yes, I think I've seen those before on NetBSD -- they look
>>>>> like a bug in your libc to me, it shouldn't be confusing itself
>>>>> with itself like that :-)
>>>>>
>>>>> thanks
>>>>> -- PMM
>>>>>
>>>>
>>>> I have filed this bug upstream: http://gnats.netbsd.org/52278
>>>>
>>>>
>>>
>>>
>>> What's the status with this patch?
>>>
>>> NetBSD build still breaks due to ivshmem-*.
>> 
>> I guess Michael expects a v4 that doesn't break the static build.
>> 
>
> -static works for me, I have restricted options to test build on !NetBSD
> systems.
>
> Was this patch ok?
>
> diff --git a/Makefile b/Makefile
> index c830d7a..2ef5a78 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -469,10 +469,12 @@ ifneq ($(EXESUF),)
>  qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
>  endif
>
> +ifdef CONFIG_IVSHMEM
>  ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
> +endif
>
>
> So I could amend it.

Please do.  Additionally consider

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f42f3df..ab70d01 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -203,7 +203,7 @@ gcov-files-pci-y += hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
 check-qtest-pci-y += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-y += hw/audio/intel-hda.c hw/audio/hda-codec.c
-check-qtest-pci-$(CONFIG_EVENTFD) += tests/ivshmem-test$(EXESUF)
+check-qtest-pci-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
 gcov-files-pci-y += hw/misc/ivshmem.c
 
 check-qtest-i386-y = tests/endianness-test$(EXESUF)
