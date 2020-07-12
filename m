Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A3C433E4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 20:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47DF20674
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 20:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47DF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juiOt-0000kO-Qw
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 16:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juiNy-0000Hy-Nx
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 16:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:50036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juiNw-0003nV-IH
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 16:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1juiNu-0003RP-BQ
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 20:15:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 495E62E80E7
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 20:15:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2020 20:01:00 -0000
From: Alexey Izbyshev <1887306@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: izbyshev
X-Launchpad-Bug-Reporter: Alexey Izbyshev (izbyshev)
X-Launchpad-Bug-Modifier: Alexey Izbyshev (izbyshev)
Message-Id: <159458406053.7310.1285869489559583574.malonedeb@wampee.canonical.com>
Subject: [Bug 1887306] [NEW] qemu-user deadlocks when forked in a
 multithreaded process
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f8faf4edf36e1bec8909e93348bdcbd74b8b9a59
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 15:00:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1887306 <1887306@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The following program (also attached) deadlocks when run under QEMU user
on Linux.

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define NUM_THREADS 100
#define NUM_FORKS 10

pthread_barrier_t barrier;

void *t(void *arg) {
    for (int i =3D 0; i < NUM_FORKS; i++) {
        pid_t pid =3D fork();
        if (pid < 0)
            abort();
        if (!pid)
            _exit(0);
        if (waitpid(pid, NULL, 0) < 0)
            abort();
    }
    //pthread_barrier_wait(&barrier);
    return NULL;
}

int main(void) {
    pthread_barrier_init(&barrier, NULL, NUM_THREADS);
    pthread_t ts[NUM_THREADS];
    for (size_t i =3D 0; i < NUM_THREADS; i++) {
        if (pthread_create(&ts[i], NULL, t, NULL))
            abort();
    }
    for (size_t i =3D 0; i < NUM_THREADS; i++) {
        pthread_join(ts[i], NULL);
    }
    printf("Done: %d\n", getpid());
    return 0;
}

To reproduce:
$ gcc test.c -pthread
$ while qemu-x86_64 ./a.out; do :; done

(Be careful, Ctrl-C/SIGINT doesn't kill the deadlocked child).

Larger values of NUM_THREADS/NUM_FORKS lead to more often deadlocks.
With the values above it often deadlocks on the first try on my machine.
When it deadlocks, there is a child qemu process with two threads which
is waited upon by one of the worker threads of the parent.

I tried to avoid the deadlock by serializing fork() with a mutex, but it
didn't help. However, ensuring that no thread exits until all forks are
done (by adding a barrier to t()) does seem to help, at least, the
program above could run for a half an hour until I terminated it.

Tested on QEMU 5.0.0, 4.2.0 and 2.11.1, with x86_64 and AArch64 linux-
user targets.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "test.c"
   https://bugs.launchpad.net/bugs/1887306/+attachment/5392123/+files/test.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1887306

Title:
  qemu-user deadlocks when forked in a multithreaded process

Status in QEMU:
  New

Bug description:
  The following program (also attached) deadlocks when run under QEMU
  user on Linux.

  #include <pthread.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/types.h>
  #include <sys/wait.h>
  #include <unistd.h>

  #define NUM_THREADS 100
  #define NUM_FORKS 10

  pthread_barrier_t barrier;

  void *t(void *arg) {
      for (int i =3D 0; i < NUM_FORKS; i++) {
          pid_t pid =3D fork();
          if (pid < 0)
              abort();
          if (!pid)
              _exit(0);
          if (waitpid(pid, NULL, 0) < 0)
              abort();
      }
      //pthread_barrier_wait(&barrier);
      return NULL;
  }

  int main(void) {
      pthread_barrier_init(&barrier, NULL, NUM_THREADS);
      pthread_t ts[NUM_THREADS];
      for (size_t i =3D 0; i < NUM_THREADS; i++) {
          if (pthread_create(&ts[i], NULL, t, NULL))
              abort();
      }
      for (size_t i =3D 0; i < NUM_THREADS; i++) {
          pthread_join(ts[i], NULL);
      }
      printf("Done: %d\n", getpid());
      return 0;
  }

  To reproduce:
  $ gcc test.c -pthread
  $ while qemu-x86_64 ./a.out; do :; done

  (Be careful, Ctrl-C/SIGINT doesn't kill the deadlocked child).

  Larger values of NUM_THREADS/NUM_FORKS lead to more often deadlocks.
  With the values above it often deadlocks on the first try on my
  machine. When it deadlocks, there is a child qemu process with two
  threads which is waited upon by one of the worker threads of the
  parent.

  I tried to avoid the deadlock by serializing fork() with a mutex, but
  it didn't help. However, ensuring that no thread exits until all forks
  are done (by adding a barrier to t()) does seem to help, at least, the
  program above could run for a half an hour until I terminated it.

  Tested on QEMU 5.0.0, 4.2.0 and 2.11.1, with x86_64 and AArch64 linux-
  user targets.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887306/+subscriptions

