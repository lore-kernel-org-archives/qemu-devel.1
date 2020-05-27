Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C672C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95F720890
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95F720890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdysj-0008OD-2p
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdysA-0007qw-T2
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:47708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdys9-00084N-E0
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jdys6-0006YP-Iw
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 16:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8C2042E80E7
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 16:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2020 16:14:43 -0000
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
 <20200527100546.29297-3-alex.bennee@linaro.org>
 <CAHiYmc7EJVxKXZ4G96cL-Bm3tT8UR_dgr7y3oisUMnuJ0u3zaw@mail.gmail.com>
 <CAHiYmc7TYHMcitiG9ELxfz-EC8DSG1b7FeFsxXxTbu-7FSih=Q@mail.gmail.com>
Message-ID: <87pnap5p8s.fsf@linaro.org>
Subject: [Bug 1880225] Re: [PATCH v1 2/3] linux-user: deal with address wrap
 for ARM_COMMPAGE on 32 bit
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1ed9e16e5227aee150e1fa735bef4215c96810a1
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 10:55:47
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
Message-ID: <20200527161443.uTeMIhasg3u8eFKg7j4tJ4nttt400HvCd1ODrrwU2xE@z>

Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> =D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 14:05 Aleksandar =
Markovic
> <aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> =D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:07 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>> >
>> > We rely on the pointer to wrap when accessing the high address of the
>> > COMMPAGE so it lands somewhere reasonable. However on 32 bit hosts we
>> > cannot afford just to map the entire 4gb address range. The old mmap
>> > trial and error code handled this by just checking we could map both
>> > the guest_base and the computed COMMPAGE address.
>> >
>> > We can't just manipulate loadaddr to get what we want so we introduce
>> > an offset which pgb_find_hole can apply when looking for a gap for
>> > guest_base that ensures there is space left to map the COMMPAGE
>> > afterwards.
>> >
>> > This is arguably a little inefficient for the one 32 bit
>> > value (kuser_helper_version) we need to keep there given all the
>> > actual code entries are picked up during the translation phase.
>> >
>> > Fixes: ee94743034b
>> > Bug: https://bugs.launchpad.net/qemu/+bug/1880225
>>
>> For the scenario in this bug report, for today's master, before and after
>> applying this patch:
>>
>
> I am not sure how significant is this info, but I executed the test
> without applying patch 1/3, so only 2/3 was applied in the case
> "AFTER".

That is expected. The other fix only affects binaries run inside a
/proc-less chroot and the final patch is a test case for COMMPAGE
support.

-- =

Alex Benn=C3=A9e

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

