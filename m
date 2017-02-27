Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRBH-0003uk-53
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRBC-0003ck-T8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ciRBC-0003cO-K7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RJdMrF008063
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:53 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vjd4g6ea-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:53 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 16:41:50 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id C2D421DC006D
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:49 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1RJfmw920971724
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:48 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1RJflJx006483
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:48 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 16:41:31 -0300
In-Reply-To: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1488224492-20316-5-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 4/5] risugen,
 risugen_ppc64.pm: Add support ppc64 (big-endian)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

This commit adds an option to risugen in order to give the opportunity
to generated big-endian instructions. By passing --be, users force
risugen to generated big-endian instructions for ppc64.

./risugen --be --numinsns 1000 --pattern "ADD" ppc64.risu test.bin
./risugen --numinsns 1000 --pattern "ADD" ppc64.risu test.bin

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risugen          | 6 +++++-
 risugen_ppc64.pm | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/risugen b/risugen
index 6aad626..086173c 100755
--- a/risugen
+++ b/risugen
@@ -264,6 +264,7 @@ Valid options:
                    a general set you have excluded.
      --no-fp      : disable floating point: no fp init, randomization etc.
                    Useful to test before support for FP is available.
+    --be         : generate instructions in Big-Endian order (ppc64 only).
     --help       : print this message
 EOT
 }
@@ -274,6 +275,7 @@ sub main()
     my $condprob = 0;
     my $fpscr = 0;
     my $fp_enabled = 1;
+    my $big_endian = 0;
     my ($infile, $outfile);
 
     GetOptions( "help" => sub { usage(); exit(0); },
@@ -287,6 +289,7 @@ sub main()
                         die "Value \"$condprob\" invalid for option condprob (must be between 0 and 1)\n";
                     }
                 },
+                "be" => sub { $big_endian = 1; },
                 "no-fp" => sub { $fp_enabled = 0; },
         ) or return 1;
     # allow "--pattern re,re" and "--pattern re --pattern re"
@@ -317,7 +320,8 @@ sub main()
         'not_pattern_re' => \@not_pattern_re,
         'details' => \%insn_details,
         'arch' => $full_arch[0],
-        'subarch' => $full_arch[1] || ''
+        'subarch' => $full_arch[1] || '',
+        'bigendian' => $big_endian
     );
 
     write_test_code(\%params);
diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index 28b6792..46ab7b1 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -373,6 +373,10 @@ sub write_test_code($)
     my @not_pattern_re = @{ $params->{ 'not_pattern_re' } };
     my %insn_details = %{ $params->{ 'details' } };
 
+    if ($params->{ 'bigendian' } eq 1) {
+        set_endian(1);
+    }
+
     open_bin($outfile);
 
     # convert from probability that insn will be conditional to
-- 
2.7.4
