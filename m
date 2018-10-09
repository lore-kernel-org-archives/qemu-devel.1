Received: from eggs.gnu.org ([2001:4830:134:3::10]:43736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9o2H-0001u0-4G
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9o2G-0002d7-9M
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:10:37 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:33981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9o2F-0002YD-TT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:10:36 -0400
Received: by mail-oi1-x235.google.com with SMTP id v69-v6so660548oif.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:10:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1810081505210.28877@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1810081505210.28877@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 10:10:08 +0100
Message-ID: <CAFEAcA8=+c4ujHCfQcagbn_UYHLWu7Ec6EM8+6619Kp9bncOsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] possible BUG, ATS12NSOPW fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 October 2018 at 23:17, Stefano Stabellini <sstabellini@kernel.org> wrote:
> I double-checked all the addresses and they are correct. For some reason
> after starting the guest, ATS12NSOPW starts to fail for
> ffffffc006f91628, which is the same virtual address corresponding to the
> same runstate region allocated in Linux.
>
> I added a couple of printf's to QEMU and Xen:
>
> (XEN) DEBUG do_vcpu_op 1458 area.v=ffffffc006f91628
> ### This is the virtual address as passed by Linux
> [...]
> (QEMU) DEBUG do_ats_write 2256 ret=1 phys_addr=200 value=ffffffc006f91628
> (QEMU) DEBUG do_ats_write 2326 par64=80b
> ### This is the output from QEMU, I added the printks to do_ats_write, line numbers 2256 and 2326
> (XEN) p2m.c:1426: d1v0: gvirt_to_maddr failed va=0xffffffc006f91628 flags=0x1 par=0x80b
> (XEN) DEBUG translate_get_page 42 addr=ffffffc006f91628 linear=1 write=1
> (XEN) DEBUG raw_copy_to_guest 120 caller=domain.c#update_runstate_area+0x78/0x10c
> (XEN) DEBUG update_runstate_area 294
> ### This is Xen failing the copy_to_guest in update_runstate_area.
>
>
> Do you have any ideas on what's wrong? I am happy to run more tests
> with QEMU to get more data.

We'd need to look at why do_ats_write is returning a failure:
the simplest way to do that is just to step through it in
a debugger watching as it does the page table walks, to see
where it does something wrong...

(If you can repro the failure eg under 'rr' then you can use
its reverse-debug to go backwards from "oops it failed" to
find out why.)

thanks
-- PMM
