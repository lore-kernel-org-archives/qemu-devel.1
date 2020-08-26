Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2AAC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4192177B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="GMQvF/27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4192177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvnZ-0007WW-5x
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kAvn2-00075u-9J
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:48:36 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:50545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kAvmz-00080m-Sp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=63rUsodFjyvVp28Bu8/8/Qn1cvuv3zvKJP9av/vveg8=; b=GMQvF/2781i2NLybzJc6XrzXlI
 mAlqWUqVAKVhNvBPeFXranpDr+u+4gys2FR+yFars22bm9m9iqCPw78rv8i3oHczrii7GEI0rZ8yh
 fJgkPfN61+tpXP7Cw+FXsgjSYCu/0qNI69Afc9/wwyZLK6Grqh5LsGfSdaVmTloOv/+T7KNSy1V73
 JcQoz12gnOKiFGz10tB+fc6JzV15QjutLVzcCXbUMLUcU5SmmYIZ81FmJCqTP7Gte8g+z58ceDePg
 Z3WWT6hmLvNmqPHoc+Dke14a6SKHgqa3cgS1VNG44AVh8/k6euHEpVV0nuUW8brd9oaBImuooajpu
 i/8NhW3Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Geoffrey McRae <geoff@hostfission.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: PTHREAD_MUTEX_ERRORCHECK and fork()
Date: Wed, 26 Aug 2020 15:48:28 +0200
Message-ID: <1803832.CiF9An4F11@silver>
In-Reply-To: <592c10e0-8800-a847-89cc-b877ddf286c8@redhat.com>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <2337495.aVM56tU1U7@silver> <592c10e0-8800-a847-89cc-b877ddf286c8@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 09:48:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 21. August 2020 15:13:35 CEST Paolo Bonzini wrote:
> On 20/08/20 14:00, Christian Schoenebeck wrote:
> > One way would be a recursive type and logging a warning, which you
> > obviously don't like; another option would be an assertion fault instead
> > to make developers immediately aware about the double lock on early
> > testing. Because on a large scale project like this, it is almost
> > impossible for all developers to be aware about all implied locks. Don't
> > you think so?
> > 
> > At least IMO the worst case would be a double unlock on a non-recursive
> > main thread mutex and running silently into undefined behaviour.
> 
> Yes, more assertions are always fine.
> 
> We were using errorcheck mutexes until a few years ago, unfortunately we
> couldn't because they are broken with respect to fork (commit 24fa90499,
> "qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK", 2015-03-05).

I had a go on this one; you still get EPERM when trying to 
pthread_mutex_unlock() from a forked child process on a 
PTHREAD_MUTEX_ERRORCHECK mutex locked by parent process.

The common opinion though seems to be that unlocking parent's lock(s) by child 
process was illegal:
https://groups.google.com/forum/#!topic/comp.programming.threads/ywMInaZjmqo
https://sourceware.org/bugzilla/show_bug.cgi?id=2745

The relevant section from POSIX:

	fork - create a new process
	...
	A process shall be created with a single thread. If a multi-threaded 
	process calls fork(), the new process shall contain a replica of the 
	calling thread and its entire address space, possibly including the states 
	of mutexes and other resources. Consequently, to avoid errors, the child 
	process may only execute async-signal-safe operations until such time as 
	one of the exec functions is called.

https://pubs.opengroup.org/onlinepubs/9699919799/

Best regards,
Christian Schoenebeck



