Received: from eggs.gnu.org ([2001:4830:134:3::10]:43248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWLuw-0005sA-8r
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWLus-0005DK-EM
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:48:14 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:44598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWLuq-0005CF-Cm
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:48:10 -0500
Received: by mail-oi1-x22c.google.com with SMTP id m6so8944906oig.11
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 05:48:07 -0800 (PST)
MIME-Version: 1.0
References: <1538036615-32542-1-git-send-email-thuth@redhat.com>
	<1538036615-32542-4-git-send-email-thuth@redhat.com>
	<CAFEAcA_qgD3Lzfoyf4vq-79aCxaVA=_gBQK-yJOOYULHmNTZpA@mail.gmail.com>
	<20181210141607.0ef48273.cohuck@redhat.com>
	<20181210133205.GC2372@work-vm>
In-Reply-To: <20181210133205.GC2372@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 13:47:55 +0000
Message-ID: <CAFEAcA80OLJW9LqJasU71St8vsda32DGRvoM4JYavr2+qVF+_Q@mail.gmail.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>

On Mon, 10 Dec 2018 at 13:32, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> Is the problem here that the field could actually be misaligned (on
> any conceivable build) or is it just a matter of convincing clang it's
> safe?

This is mostly a "clang doesn't know that the struct field
will actually always be 4 aligned and the function being
called only requires 4 alignment" thing. But there is an
actual-in-theory problem too: because the SCHIB struct is
marked QEMU_PACKED it has no alignment requirements at all.
So in for instance css_do_msch() the compiler is entitled
to align the local "SCHIB schib" at any alignment it likes,
which may not be the 4-alignment that copy_pmcw_from_guest()
assumes.

An option (3) which I hadn't previously thought of:
copy the pmcw and scsw fields into and out of locals
which are guaranteed to be correctly aligned:

--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1290,9 +1290,15 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
 static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
+    PMCW srcpmcw, destpmcw;
+    SCSW srcscsw, destscsw;

-    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_to_guest(&dest->scsw, &src->scsw);
+    srcpmcw = src->pmcw;
+    copy_pmcw_to_guest(&destpmcw, &srcpmcw);
+    dest->pmcw = destpmcw;
+    srcscsw = src->scsw;
+    copy_scsw_to_guest(&destscsw, &srcscsw);
+    dest->scsw = destscsw;
     dest->mba = cpu_to_be64(src->mba);
     for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
         dest->mda[i] = src->mda[i];
@@ -1339,9 +1345,15 @@ static void copy_scsw_from_guest(SCSW *dest,
const SCSW *src)
 static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
+    PMCW srcpmcw, destpmcw;
+    SCSW srcscsw, destscsw;

-    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_from_guest(&dest->scsw, &src->scsw);
+    srcpmcw = src->pmcw;
+    copy_pmcw_from_guest(&destpmcw, &srcpmcw);
+    dest->pmcw = destpmcw;
+    srcscsw = src->scsw;
+    copy_scsw_from_guest(&destscsw, &srcscsw);
+    dest->scsw = destscsw;
     dest->mba = be64_to_cpu(src->mba);
     for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
         dest->mda[i] = src->mda[i];

thanks
-- PMM
