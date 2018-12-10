Received: from eggs.gnu.org ([2001:4830:134:3::10]:46869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWKfa-0002iz-02
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWKfW-0004Iz-GV
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:28:16 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWKfU-0004FN-8x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:28:14 -0500
Received: by mail-oi1-x242.google.com with SMTP id i6so8788458oia.6
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 04:28:08 -0800 (PST)
MIME-Version: 1.0
References: <1538036615-32542-1-git-send-email-thuth@redhat.com>
	<1538036615-32542-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1538036615-32542-4-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 12:27:56 +0000
Message-ID: <CAFEAcA_qgD3Lzfoyf4vq-79aCxaVA=_gBQK-yJOOYULHmNTZpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] hw/s390x/ioinst: Fix alignment
 problem in struct SubchDev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

On Thu, 27 Sep 2018 at 09:25, Thomas Huth <thuth@redhat.com> wrote:
>
> struct SubchDev embeds several other structures which are marked with
> QEMU_PACKED. This causes the compiler to not care for proper alignment
> of these structures. When we later pass around pointers to the unaligned
> struct members during migration, this causes problems on host architectures
> like Sparc that can not do unaligned memory access.
>
> Most of the structs in ioinst.h are naturally aligned, so we can fix
> most of the problem by removing the QEMU_PACKED statements (and use
> QEMU_BUILD_BUG_MSG() statements instead to make sure that there is no
> padding). However, for the struct SCHIB, we have to keep the QEMU_PACKED
> since the compiler adds some padding here otherwise. Move this struct
> to the beginning of struct SubchDev instead to fix the alignment problem
> here, too.

Unfortunately clang does not like the struct SCHIB being still
marked packed:

/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1294:25:
warning: taking address of packed member 'pmcw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
                        ^~~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1294:38:
warning: taking address of packed member 'pmcw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
                                     ^~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1295:25:
warning: taking address of packed member 'scsw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_scsw_to_guest(&dest->scsw, &src->scsw);
                        ^~~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1295:38:
warning: taking address of packed member 'scsw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_scsw_to_guest(&dest->scsw, &src->scsw);
                                     ^~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1343:27:
warning: taking address of packed member 'pmcw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
                          ^~~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1343:40:
warning: taking address of packed member 'pmcw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
                                       ^~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1344:27:
warning: taking address of packed member 'scsw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_scsw_from_guest(&dest->scsw, &src->scsw);
                          ^~~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/s390x/css.c:1344:40:
warning: taking address of packed member 'scsw' of class or structure
'SCHIB' may result in an unaligned pointer value
[-Waddress-of-packed-member]
    copy_scsw_from_guest(&dest->scsw, &src->scsw);
                                       ^~~~~~~~~


Not sure how best to address this. A couple of ideas that I had:

(1) make the 'uint64_t mba' field in the SCHIB struct into
two uint32_t fields, adjusting all the code which needs
to access it accordingly; then we could drop the packed
annotation from the struct

(2) have the guts of copy_{pmcw,scsw}_{to,from}_guest() be
macros, so we can do them inline in the copy_schib_{to,from}_guest()
function and thus operate directly on src->pmcw.foo &c
fields rather than ever having to take the address of any
of the fields in src or dest

thanks
-- PMM
