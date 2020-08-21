Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BA5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C606A20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AS/lzt6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C606A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Rz-0005LC-0u
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k94yg-0005gf-B1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:12:58 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:34183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k94ye-0007iI-2x
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=21XtnTBHnGdvUqtRi1C7zWAcG0gfx6c5QpGtqb0IQ28=; b=AS/lzt6lWfAcvOehuAm3RBF92D
 w8SHNtTXajo8o3V83hA9KwgcyeWYdVcsBca4reHAaS77L7HJQnNri69RZCxvSVBwgxNhXlziCUbjQ
 782fLBZ9BAQMkebkSt/8Rg/C+K3fP99WbkYZeL4eI9hTCEUmc9LTbZYxexSSRggKdYE0NDCQbJpP+
 9pKvDCYoatII7KvwJ/uFZq72rxvKSKa+LRLO0tdLHgArKAXjUE6AEP+w6NrL9HY2o9Z5k+cswfduD
 dYa74qPQu31JSp/+t6eaDld3ndhEyDegfD/TLwAwZwv+N6sWvdXMGvA0MtbVbGexlfGwtX7g1/rzm
 p4bv1BnA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Geoffrey McRae <geoff@hostfission.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: recursive locks (in general)
Date: Fri, 21 Aug 2020 13:12:50 +0200
Message-ID: <4046931.6zmTeCK0lb@silver>
In-Reply-To: <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <3140676.b1PlGooJ8z@silver> <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 07:12:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Donnerstag, 20. August 2020 12:54:49 CEST Paolo Bonzini wrote:
> More seriously: programming with concurrency is first and foremost about
> understanding invariants[1].  Locks are relatively simple to reason
> about because they enforce invariants at the points where they are
> acquired or released.

As a side note, independent of the actual QBL issue discussed, while I agree 
with you that nested locks should be avoided as much as possible, especially 
on heterogenous large scale projects like QEMU; please let me correct some of 
the things you said about recursive locks in general:

> However, recursive locks are pure evil. :)

That's a common overgeneralization of the potential issues when dealing with 
recursive locks. Especially this claim ...

> but callers have no clue about what invariants are provided around calls
> to do_it().  So, understanding complex code that uses recursive mutexes
> is effectively impossible.

... is incorrect.

It is correct that you can run into deadlocks if you don't know how to deal 
with nested recursive locks appropriately. It is incorrect though to say they 
were not managable.

There is a golden rule with recursive locks: You always have to preserve a 
clear hierarchy. Say you have the following recursive mutexes:

RecursiveMutex mutex0;
RecursiveMutex mutex1;
RecursiveMutex mutex2;
...
RecursiveMutex mutexN;

where the suffix shall identify the hierarchy, i.e. h(mutex0) = 0,
h(mutex1) = 1, ... h(mutexN) = N. Then the golden rule is that in any call 
stack the nested locks must always preserve the same transitive hierarchy, 
e.g.:

	h(lock1) <= h(lock2) <= ... <= h(lockK)

Example (using lock-guard notation), let's say ascending transitivity is 
chosen, then the following is Ok, as it does not violate chosen transitivity:

	synchronized(mutex0) {
		synchronized(mutex1) {
			...
			synchronized(mutexN) {
			}
		}
	}

Likewise, the following is Ok as well:

	synchronized(mutex3) {
		synchronized(mutex8) {
			...
			synchronized(mutexN) {
			}
		}
	}

whereas this would be illegal:

	synchronized(mutex3) {
		synchronized(mutex2) { // < violates chosen transitivity
			...
			synchronized(mutexN) {
			}
		}
	}

Now let's say one day somebody accidentally broke that rule and ran into a 
deadlock. What you can do to resolve the situation is capturing the call stack 
of each mutex's [last] lock. And when you triggered the deadlock, you know 
that at least one of the threads violated the lock hierarchy. So you look at 
the individual call stacks and correct the program flow appropriately to 
restore the hierarchy. And the latter is BTW independent of (i.e. any side 
effects) of other threads, so it is really just about looking at what exactly 
ONE thread is doing.

And for the latter reason, there are also more systematic approaches to ensure 
correctness: for instance a built-in hierarchy check in the individual Mutex 
implementation which would then e.g. raise an assertaion fault on early 
testing whenever a developer broke the hierarchy in a nested lock sequence.

Another solution would be integrating this hierarchy check into a (e.g. 
static) sanatizer, as this information can already be derived directly from 
the AST in most cases. But unfortunatley this does not exist yet in any 
sanatizer yet AFAIK.

For me, a non-recursive mutex makes sense for one use case: if the intention 
is to lock the mutex on one thread while allowing to unlock it on another 
thread. For all other use cases I would (personally) prefer a recursive type, 
as it guards a clear ownership relation and hence allows to guard and prevent 
many mistakes.

Best regards,
Christian Schoenebeck



