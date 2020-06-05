Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12222C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CB5206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CB5206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEoL-0000nv-19
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhEh8-000638-UW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:55:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:42222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhEh6-0005IG-Rk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:55:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jhEh4-0002jZ-UU
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 15:55:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E4AE42E8105
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 15:55:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2020 15:49:27 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <1880225@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: arm testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee aleksandar-markovic
X-Launchpad-Bug-Reporter: Aleksandar Markovic (aleksandar-markovic)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <159017301531.7966.9120113243897778171.malonedeb@gac.canonical.com>
Message-ID: <20200605154929.26910-13-alex.bennee@linaro.org>
Subject: [Bug 1880225] [PATCH v1 12/14] linux-user: deal with address wrap for
 ARM_COMMPAGE on 32 bit
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fc64c351058f7a230af6fb6e0367eb6da0804447
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 11:55:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1880225 <1880225@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200605154927.2d_U_N7VV0VUvcgMf_m8f2rOqCu2KsrLeNIIQWq0N64@z>

We rely on the pointer to wrap when accessing the high address of the
COMMPAGE so it lands somewhere reasonable. However on 32 bit hosts we
cannot afford just to map the entire 4gb address range. The old mmap
trial and error code handled this by just checking we could map both
the guest_base and the computed COMMPAGE address.

We can't just manipulate loadaddr to get what we want so we introduce
an offset which pgb_find_hole can apply when looking for a gap for
guest_base that ensures there is space left to map the COMMPAGE
afterwards.

This is arguably a little inefficient for the one 32 bit
value (kuser_helper_version) we need to keep there given all the
actual code entries are picked up during the translation phase.

Fixes: ee94743034b
Bug: https://bugs.launchpad.net/qemu/+bug/1880225
Cc: Bug 1880225 <1880225@bugs.launchpad.net>
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200527100546.29297-3-alex.bennee@linaro.org>

---
v3
  - base offset on ARM_COMMPAGE
  - ensure we MAP_FIXED the commpage
  - support offset in pgd_find_hole_fallback
---
 linux-user/elfload.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 475d243f3bd..b5cb21384a1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -389,7 +389,7 @@ static bool init_guest_commpage(void)
 {
     void *want =3D g2h(ARM_COMMPAGE & -qemu_host_page_size);
     void *addr =3D mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 =

     if (addr =3D=3D MAP_FAILED) {
         perror("Allocating guest commpage");
@@ -2113,7 +2113,8 @@ static void pgb_have_guest_base(const char *image_nam=
e, abi_ulong guest_loaddr,
  * only dumbly iterate up the host address space seeing if the
  * allocation would work.
  */
-static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t br=
k, long align)
+static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t br=
k,
+                                        long align, uintptr_t offset)
 {
     uintptr_t base;
 =

@@ -2123,7 +2124,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t gue=
st_size, uintptr_t brk, lon
     while (true) {
         uintptr_t align_start, end;
         align_start =3D ROUND_UP(base, align);
-        end =3D align_start + guest_size;
+        end =3D align_start + guest_size + offset;
 =

         /* if brk is anywhere in the range give ourselves some room to gro=
w. */
         if (align_start <=3D brk && brk < end) {
@@ -2138,7 +2139,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t gue=
st_size, uintptr_t brk, lon
                                      PROT_NONE, flags, -1, 0);
             if (mmap_start !=3D MAP_FAILED) {
                 munmap((void *) align_start, guest_size);
-                return (uintptr_t) mmap_start;
+                return (uintptr_t) mmap_start + offset;
             }
             base +=3D qemu_host_page_size;
         }
@@ -2147,7 +2148,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t gue=
st_size, uintptr_t brk, lon
 =

 /* Return value for guest_base, or -1 if no hole found. */
 static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_siz=
e,
-                               long align)
+                               long align, uintptr_t offset)
 {
     GSList *maps, *iter;
     uintptr_t this_start, this_end, next_start, brk;
@@ -2161,7 +2162,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr=
, uintptr_t guest_size,
     brk =3D (uintptr_t)sbrk(0);
 =

     if (!maps) {
-        return pgd_find_hole_fallback(guest_size, brk, align);
+        return pgd_find_hole_fallback(guest_size, brk, align, offset);
     }
 =

     /* The first hole is before the first map entry. */
@@ -2173,7 +2174,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr=
, uintptr_t guest_size,
 =

         this_end =3D ((MapInfo *)iter->data)->start;
         next_start =3D ((MapInfo *)iter->data)->end;
-        align_start =3D ROUND_UP(this_start, align);
+        align_start =3D ROUND_UP(this_start + offset, align);
 =

         /* Skip holes that are too small. */
         if (align_start >=3D this_end) {
@@ -2223,6 +2224,7 @@ static void pgb_static(const char *image_name, abi_ul=
ong orig_loaddr,
 {
     uintptr_t loaddr =3D orig_loaddr;
     uintptr_t hiaddr =3D orig_hiaddr;
+    uintptr_t offset =3D 0;
     uintptr_t addr;
 =

     if (hiaddr !=3D orig_hiaddr) {
@@ -2236,18 +2238,19 @@ static void pgb_static(const char *image_name, abi_=
ulong orig_loaddr,
     if (ARM_COMMPAGE) {
         /*
          * Extend the allocation to include the commpage.
-         * For a 64-bit host, this is just 4GiB; for a 32-bit host,
-         * the address arithmetic will wrap around, but the difference
-         * will produce the correct allocation size.
+         * For a 64-bit host, this is just 4GiB; for a 32-bit host we
+         * need to ensure there is space bellow the guest_base so we
+         * can map the commpage in the place needed when the address
+         * arithmetic wraps around.
          */
         if (sizeof(uintptr_t) =3D=3D 8 || loaddr >=3D 0x80000000u) {
-            hiaddr =3D (uintptr_t)4 << 30;
+            hiaddr =3D (uintptr_t) 4 << 30;
         } else {
-            loaddr =3D ARM_COMMPAGE & -align;
+            offset =3D -(ARM_COMMPAGE & -align);
         }
     }
 =

-    addr =3D pgb_find_hole(loaddr, hiaddr - loaddr, align);
+    addr =3D pgb_find_hole(loaddr, hiaddr - loaddr, align, offset);
     if (addr =3D=3D -1) {
         /*
          * If ARM_COMMPAGE, there *might* be a non-consecutive allocation
@@ -2282,7 +2285,7 @@ static void pgb_dynamic(const char *image_name, long =
align)
          * just above that, and maximises the positive guest addresses.
          */
         commpage =3D ARM_COMMPAGE & -align;
-        addr =3D pgb_find_hole(commpage, -commpage, align);
+        addr =3D pgb_find_hole(commpage, -commpage, align, 0);
         assert(addr !=3D -1);
         guest_base =3D addr;
     }
-- =

2.20.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880225

Title:
  Emulation of some arm programs fail with "Assertion `have_guest_base'
  failed."

Status in QEMU:
  In Progress

Bug description:
  This issue is observer with QEMU ToT, checked out around May 15th (but
  I believe it is present in current master too), and wasn't present in
  QEMU v5.0.0.

  I am using 32-bit Intel(R) Pentium(R) M processor 1.73GHz host.

  Arm cross-compiler is a standard cross-compiler that comes with
  Debian-based distributions, and gcc version is:

  $ arm-linux-gnueabi-gcc --version
  arm-linux-gnueabi-gcc (Debian 8.3.0-2) 8.3.0

  Compile this program with cross compiler:

  $ arm-linux-gnueabi-gcc -O2 -static toupper_string.c -o
  toupper_string-arm

  Emulation with QEMU v5.0.0 is correct, and gives expected output:

  $ ~/Build/qemu-5.0.0/build-gcc/arm-linux-user/qemu-arm ./toupper_string-a=
rm
  CONTROL RESULT: (toupper_string)
   nwlrbbmqbhcdarz owkkyhiddqscdxr jmowfrxsjybldbe fsarcbynecdyggx xpklorel=
lnmpapq
   NWLRBBMQBHCDARZ OWKKYHIDDQSCDXR JMOWFRXSJYBLDBE FSARCBYNECDYGGX XPKLOREL=
LNMPAPQ

  While, in case of QEMU master it fails:

  $ ~/Build/qemu-master/build-gcc/arm-linux-user/qemu-arm ./toupper_string-=
arm
  qemu-arm: /home/rtrk/Build/qemu-master/linux-user/elfload.c:2294: probe_g=
uest_base: Assertion `have_guest_base' failed.
  Aborted

  There are many other programs that exibit the same behavior. The
  failure is arm-sprecific.

  =

  -----------------------------------------------------

  source code: (let's call this file toupper_string.c) (similar file is
  also in attachment)

  =

  #include <stdlib.h>
  #include <string.h>
  #include <stdio.h>
  #include <unistd.h>

  =

  #define MAX_STRING_LENGHT              15
  #define NUMBER_OF_RANDOM_STRINGS       100
  #define DEFAULT_NUMBER_OF_REPETITIONS  30000
  #define MAX_NUMBER_OF_REPETITIONS      1000000000
  #define NUMBER_OF_CONTROL_PRINT_ITEMS  5

  /* Structure for keeping an array of strings */
  struct StringStruct {
      char chars[MAX_STRING_LENGHT + 1];
  };

  /**
   * Sets characters of the given string to random small letters a-z.
   * @param s String to get random characters.
   * @len Length of the input string.
   */
  static void gen_random_string(char *chars, const int len)
  {
      static const char letters[] =3D "abcdefghijklmnopqrstuvwxyz";

      for (size_t i =3D 0; i < len; i++) {
          chars[i] =3D letters[rand() % (sizeof(letters) - 1)];
      }
      chars[len] =3D 0;
  }

  void main (int argc, char* argv[])
  {
      struct StringStruct random_strings[NUMBER_OF_RANDOM_STRINGS];
      struct StringStruct strings_to_be_uppercased[NUMBER_OF_RANDOM_STRINGS=
];
      int32_t number_of_repetitions =3D DEFAULT_NUMBER_OF_REPETITIONS;
      int32_t option;

      /* Parse command line options */
      while ((option =3D getopt(argc, argv, "n:")) !=3D -1) {
          if (option =3D=3D 'n') {
              int32_t user_number_of_repetitions =3D atoi(optarg);
              /* Check if the value is a negative number */
              if (user_number_of_repetitions < 1) {
                  fprintf(stderr, "Error ... Value for option '-n' cannot b=
e a "
                                  "negative number.\n");
                  exit(EXIT_FAILURE);
              }
              /* Check if the value is a string or zero */
              if (user_number_of_repetitions =3D=3D 0) {
                  fprintf(stderr, "Error ... Invalid value for option '-n'.=
\n");
                  exit(EXIT_FAILURE);
              }
              /* Check if the value is too large */
              if (user_number_of_repetitions > MAX_NUMBER_OF_REPETITIONS) {
                  fprintf(stderr, "Error ... Value for option '-n' cannot b=
e "
                                  "more than %d.\n", MAX_NUMBER_OF_REPETITI=
ONS);
                  exit(EXIT_FAILURE);
              }
              number_of_repetitions =3D user_number_of_repetitions;
          } else {
              exit(EXIT_FAILURE);
          }
      }

      /* Create an array of strings with random content */
      srand(1);
      for (size_t i =3D 0; i < NUMBER_OF_RANDOM_STRINGS; i++) {
          gen_random_string(random_strings[i].chars, MAX_STRING_LENGHT);
      }

      /* Perform uppercasing of a set of random strings multiple times */
      for (size_t j =3D 0; j < number_of_repetitions; j++) {
          /* Copy initial set of random strings to the set to be uppercased=
 */
          memcpy(strings_to_be_uppercased, random_strings,
                 NUMBER_OF_RANDOM_STRINGS * (MAX_STRING_LENGHT + 1));
          /* Do actual changing case to uppercase */
          for (size_t i =3D 0; i < NUMBER_OF_RANDOM_STRINGS; i++) {
              int k =3D 0;
    =

              while (strings_to_be_uppercased[i].chars[k]) { =

                  char ch =3D strings_to_be_uppercased[i].chars[k] - 32; =

                  memcpy((void *)strings_to_be_uppercased[i].chars + k,
                         &ch, 1);
                  k++; =

              } =

          }
      }

      /* Control printing */
      printf("CONTROL RESULT: (toupper_string)\n");
      for (size_t i =3D 0; i < NUMBER_OF_CONTROL_PRINT_ITEMS; i++) {
          printf(" %s", random_strings[i].chars);
      }
      printf("\n");
      for (size_t i =3D 0; i < NUMBER_OF_CONTROL_PRINT_ITEMS; i++) {
          printf(" %s", strings_to_be_uppercased[i].chars);
      }
      printf("\n");
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880225/+subscriptions

