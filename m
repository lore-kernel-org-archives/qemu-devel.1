Received: from eggs.gnu.org ([2001:4830:134:3::10]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1ffIoj-00040V-Cb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 01:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1ffIof-0001qj-BE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 01:46:33 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:46317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1ffIoe-0001q5-Sm
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 01:46:29 -0400
Received: by mail-ed1-x542.google.com with SMTP id o8-v6so138854edt.13
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 22:46:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153177183866.7766.1789433991037567183@sif>
References: <20180624124540.6659-1-sameeh@daynix.com>
	<153177183866.7766.1789433991037567183@sif>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 17 Jul 2018 08:46:27 +0300
Message-ID: <CAKPgXcF64Bq+xfFRojYwHS-s3HjNS8s=1Lix4C9Z16Y5Ez3yCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qga-win: Handle fstrim for OSes lower than
 Win8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

I'v successfully compiled the previous patch on Fedora 27, but it seems to
be failing on RHEL, You can apply this patch instead which avoids using the
versionhelpers header:
---
 qga/commands-win32.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index fb91f5d..e688e71 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -846,6 +846,17 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum,
Error **errp)
     GuestFilesystemTrimResponse *resp;
     HANDLE handle;
     WCHAR guid[MAX_PATH] = L"";
+    OSVERSIONINFO osvi;
+    BOOL bIsWindows8orLater;
+
+    ZeroMemory(&osvi, sizeof(OSVERSIONINFO));
+    osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+    GetVersionEx(&osvi);
+    bIsWindows8orLater = ((osvi.dwMajorVersion == 6) &&
(osvi.dwMinorVersion >= 2));
+    if (!bIsWindows8orLater) {
+         error_setg(errp, "fstrim is only supported for Win8+");
+         return NULL;
+    }

     handle = FindFirstVolumeW(guid, ARRAYSIZE(guid));
     if (handle == INVALID_HANDLE_VALUE) {
--
2.8.1.185.gdc0db2c


On Mon, Jul 16, 2018 at 11:10 PM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Quoting Sameeh Jubran (2018-06-24 07:45:40)
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > The defrag.exe tool which is used for executing the fstrim command
> > on Windows doesn't support retrim for OSes lower than Win8. This
> > commit handles this case and returns a suitable error.
> >
> > Output of fstrim before this commit:
> > {"execute":"guest-fstrim"}
> > {"return": {"paths": [{"path": "C:\\", "error": "An invalid command line
> option
> > was specified. (0x89000008)"}, {"path": "F:\\", "error": "An invalid
> command
> > line option was specified. (0x89000008)"}, {"path": "S:\\", "error": "An
> > invalid command line option was specified. (0x89000008)"}]}}
> >
> > Reported on:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1594113
> >
> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> > ---
> >  qga/commands-win32.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index d79974f212..0bdcd9dd38 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -30,6 +30,7 @@
> >  #include <lm.h>
> >  #include <wtsapi32.h>
> >  #include <wininet.h>
> > +#include <versionhelpers.h>
>
> I have this queued locally but the mingw64 build environment I've been
> using (fc20) doesn't support this header and I'm running into some odd
> null pointer / 0xc0000005 / access violation issues with the binary
> generated in newer tool chains. I'll send a pull for this next week when
> I can get it tested.
>
> What build envionment are you using?
>
> >
> >  #include "qga/guest-agent-core.h"
> >  #include "qga/vss-win32.h"
> > @@ -852,6 +853,11 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum,
> Error **errp)
> >      HANDLE handle;
> >      WCHAR guid[MAX_PATH] = L"";
> >
> > +   if (!IsWindows8OrGreater()) {
> > +        error_setg(errp, "fstrim is only supported for Win8+");
> > +        return NULL;
> > +   }
> > +
> >      handle = FindFirstVolumeW(guid, ARRAYSIZE(guid));
> >      if (handle == INVALID_HANDLE_VALUE) {
> >          error_setg_win32(errp, GetLastError(), "failed to find any
> volume");
> > --
> > 2.13.6
> >
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
