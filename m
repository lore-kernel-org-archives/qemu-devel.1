Received: from eggs.gnu.org ([2001:4830:134:3::10]:52949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gacqc-0001tH-RH
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 03:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gacqZ-0004Ut-Mz
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 03:41:26 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gacqZ-0004UD-Gj
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 03:41:23 -0500
Received: by mail-wm1-f52.google.com with SMTP id n190so7302590wmd.0
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 00:41:22 -0800 (PST)
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
Date: Sat, 22 Dec 2018 09:41:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21/12/18 22:09, Peter Maydell wrote:
> I don't really understand what's going on here, or why
> it only happens with this one system (my main x86-64
> Linux Ubuntu 16.04.5 box) and not the various others I'm
> running test builds on. But it does seem to be 100%
> reliable with any of these pullreqs with the new test
> driver in them :-(

I'm afraid something in your setup is causing make's stdout to have
O_NONBLOCK set.  Make doesn't use O_NONBLOCK at all, so it must be
something above it.  I also checked Perl with strace and, at least here,
it doesn't set O_NONBLOCK.

So here are some ideas... First, can you try applying something like
this to reproduce?

--- a/Makefile
+++ b/Makefile
@@ -17,9 +17,13 @@ print-%:
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
 # Put the all: rule here so that config-host.mak can contain dependencies.
-all:
+all: lotsofoutput
 include config-host.mak

+.PHONY: lotsofoutput
+lotsofoutput:
+	yes 1234567890 | head -n 10000
+
 git-submodule-update:

 .PHONY: git-submodule-update


And please try applying this, which is a bit of a shot in the dark but
1) it is a good idea anyway; 2) it may help, if not alone, together with
the workarounds below:

diff --git a/scripts/tap-driver.pl b/scripts/tap-driver.pl
index 5e59b5db49..6621a5cd67 100755
--- a/scripts/tap-driver.pl
+++ b/scripts/tap-driver.pl
@@ -313,6 +313,7 @@ sub main ()
   my $iterator = TAP::Parser::Iterator::Stream->new(\*STDIN);
   my $parser = TAP::Parser->new ({iterator => $iterator });

+  STDOUT->autoflush(1);
   while (defined (my $cur = $parser->next))
     {
       # Parsing of TAP input should stop after a "Bail out!" directive.
diff --git a/scripts/tap-merge.pl b/scripts/tap-merge.pl
index 59e3fa5007..10ccf57bb2 100755
--- a/scripts/tap-merge.pl
+++ b/scripts/tap-merge.pl
@@ -53,6 +53,7 @@ sub main ()
   my $testno = 0;     # Number of test results seen so far.
   my $bailed_out = 0; # Whether a "Bail out!" directive has been seen.

+  STDOUT->autoflush(1);
   while (defined (my $cur = $parser->next))
     {
       if ($cur->is_bailout)

Possible workarounds include:

- using "make -Oline" or "make -Onone" (for -Oline, it may require the
above autoflush patch).

- running this Python script before invoking make

    import os
    from fcntl import *
    fcntl(1, F_SETFL, fcntl(1, F_GETFL) & ~os.O_NONBLOCK)

Paolo
