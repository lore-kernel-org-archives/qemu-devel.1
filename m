Received: from eggs.gnu.org ([209.51.188.92]:48934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcMG-0003UH-Tj
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcMF-0008LJ-MP
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:12:04 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpcMC-0008K3-K2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:12:01 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so6897083wmj.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:11:59 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-10-peter.maydell@linaro.org>
	<87r2crv5um.fsf@zen.linaroharston>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87r2crv5um.fsf@zen.linaroharston>
Date: Fri, 01 Feb 2019 17:11:57 +0000
Message-ID: <87a7jfv3fm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Add support to our configure and makefile machinery for building
>> our rST docs into HTML files.
>>
>> Building the documentation now requires that sphinx-build is
>> available; this seems better than allowing half the docs to
>> be built if it is not present but having half of them missing.
>> (In particular it means that assuming that distros configured with
>> --enable-docs they'll get a helpful error from configure telling
>> them the new build dependency.)
>
> Hmm we manage to break Travis CI:
>
>   https://travis-ci.org/stsquad/qemu/jobs/487512292#L902
>
> It reports:
>
>   Documentation     no
>
> But then proceeds to barf:
>
>   https://travis-ci.org/stsquad/qemu/jobs/487512292#L1395
>
> with:
>
>   /bin/sh: 1: sphinx-build: not found
>   Makefile:871: recipe for target 'docs/devel/index.html' failed
>   make: *** [docs/devel/index.html] Error 127

I did the following:

modified   Makefile
@@ -322,6 +322,7 @@ endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 DOCS+=3Dscripts/qemu-trace-stap.1
 endif
+DOCS+=3Dsphinxdocs
 else
 DOCS=3D
 endif
@@ -401,7 +402,7 @@ dummy :=3D $(call unnest-vars,, \

 include $(SRC_PATH)/tests/Makefile.include

-all: $(DOCS) sphinxdocs $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules

 qemu-version.h: FORCE
 	$(call quiet-command, \
@@ -699,13 +700,7 @@ for d in $$(cd docs && find $1 -type d); do $(INSTALL_=
DIR) "$(DESTDIR)$(qemu_doc
 for f in $$(cd docs && find $1 -type f); do $(INSTALL_DATA) "docs/$$f" "$(=
DESTDIR)$(qemu_docdir)/$$f"; done
 endef

-# Note that we deliberately do not install the "devel" manual: it is
-# for QEMU developers, and not interesting to our users.
-.PHONY: install-sphinxdocs
-install-sphinxdocs: sphinxdocs
-	$(call install-manual,interop)
-
-install-doc: $(DOCS) install-sphinxdocs
+install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
@@ -737,6 +732,7 @@ ifdef CONFIG_VIRTFS
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
+	$(call install-manual,interop)

 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"

--
Alex Benn=C3=A9e
