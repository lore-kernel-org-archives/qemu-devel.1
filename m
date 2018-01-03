Received: from eggs.gnu.org ([2001:4830:134:3::10]:44738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWnNP-0006kP-Cz
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWnNN-0003RR-3u
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:02:55 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:39917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWnNM-0003PM-NN
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:02:52 -0500
Received: by mail-wm0-x22e.google.com with SMTP id i11so4074801wmf.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:02:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96TDZR7O75q_NH_vOdLBYr3ygnx-qzoZrQaeRqfrHAkA@mail.gmail.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-5-marcandre.lureau@redhat.com>
	<CAJ+F1CLxk6vC+ZB09BUBMnJj12RuaeYS=S5KwcBGhoHiYbCd5g@mail.gmail.com>
	<CAJ+F1CLHsFoRFYy825f0MxyAU4T+97YrjMQWfmu6Cni49zyZWQ@mail.gmail.com>
	<bfe98eaa-bf87-dabe-ec63-7eae338495a2@redhat.com>
	<CAFEAcA96TDZR7O75q_NH_vOdLBYr3ygnx-qzoZrQaeRqfrHAkA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jan 2018 19:02:50 +0100
Message-ID: <CAJ+F1C+xQGWy8jCEXwzPg17vWJxixVydzEf_jb-FvjohTKwPng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/13] build-sys: add AddressSanitizer
 when --enable-debug if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

Hi

On Wed, Jan 3, 2018 at 6:52 PM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On 2 January 2018 at 17:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> 2) I think removing -O2 from --enable-debug should be removed at the
>> same time.  That pretty much guarantees that nobody will use
>> --enable-debug, and optimized builds are decently debuggable nowadays.
>> The best would be to detect -Og, and add either -Og or -O1 depending on
>> presence.
>
> Hmm. I use --enable-debug all the time and one of the reasons
> I use it is that the optimized build is usually more pain
> to debug with...

       -Og Optimize debugging experience.  -Og enables optimizations
that do not interfere with debugging. It should be the optimization
level of choice for the standard edit-compile-debug cycle, offering
           a reasonable level of optimization while maintaining fast
compilation and a good debugging experience.

That should cover debugging nicely. Tbh, I am quite happy with
compiler default to O0 when --enable-debug. Og doesn't give me much
different experience.

However, it produces false-positive warnings with gcc. Quoting the
patch I was about to send:

    Unfortunately, gcc has many false-positive maybe-uninitialized
    errors with Og and O1 (f27 gcc 7.2.1 20170915):

    /home/elmarco/src/qemu/hw/ipmi/isa_ipmi_kcs.c: In function
=E2=80=98ipmi_kcs_ioport_read=E2=80=99:
    /home/elmarco/src/qemu/hw/ipmi/isa_ipmi_kcs.c:279:12: error: =E2=80=98r=
et=E2=80=99
may be used uninitialized in this function
[-Werror=3Dmaybe-uninitialized]
         return ret;
                ^~~
    cc1: all warnings being treated as errors
    make: *** [/home/elmarco/src/qemu/rules.mak:66:
hw/ipmi/isa_ipmi_kcs.o] Error 1
    make: *** Waiting for unfinished jobs....
    /home/elmarco/src/qemu/hw/ide/ahci.c: In function =E2=80=98ahci_populat=
e_sglist=E2=80=99:
    /home/elmarco/src/qemu/hw/ide/ahci.c:903:58: error:
=E2=80=98tbl_entry_size=E2=80=99 may be used uninitialized in this function
[-Werror=3Dmaybe-uninitialized]
             if ((off_idx =3D=3D -1) || (off_pos < 0) || (off_pos >
tbl_entry_size)) {
                                                     ~~~~~~~~~^~~~~~~~~~~~~=
~~~~
    cc1: all warnings being treated as errors
    make: *** [/home/elmarco/src/qemu/rules.mak:66: hw/ide/ahci.o] Error 1
    /home/elmarco/src/qemu/hw/display/qxl.c: In function =E2=80=98qxl_add_m=
emslot=E2=80=99:
    /home/elmarco/src/qemu/hw/display/qxl.c:1397:52: error:
=E2=80=98pci_start=E2=80=99 may be used uninitialized in this function
[-Werror=3Dmaybe-uninitialized]
         memslot.virt_end   =3D virt_start + (guest_end   - pci_start);
                                           ~~~~~~~~~~~~~^~~~~~~~~~~~
    /home/elmarco/src/qemu/hw/display/qxl.c:1389:9: error:
=E2=80=98pci_region=E2=80=99 may be used uninitialized in this function
[-Werror=3Dmaybe-uninitialized]
             qxl_set_guest_bug(d, "%s: pci_region =3D %d", __func__, pci_re=
gion);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
    cc1: all warnings being treated as errors

    There seems to be a long list of related bugs in upstream GCC, some of
    them are being fixed very recently:
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D24639

    For now, let's workaround it by using Wno-maybe-uninitialized (gcc-only=
).


--=20
Marc-Andr=C3=A9 Lureau
