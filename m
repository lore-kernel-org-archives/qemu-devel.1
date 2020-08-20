Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A6FC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162B5206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZlVi+85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162B5206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8iEd-00077g-BX
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8iDv-0006bx-2M
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:55:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8iDs-0006U0-NU
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597920907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UWgLqombtRgUjlrWroJfuMntbtaAZTLGT5j9WAlzqI=;
 b=eZlVi+85pQkw4EEsxQIFKhOLHhzjj6c5iq6ixMyuw6rGaQDrRN59Uxx2RBTyMVMxeEDPKx
 N0tJTy3vFXEWUwMVhL4d0VsApvhi60M/pyJjf6BR9dGoQ1cSAg8QsGu8oOz0p8hc9p6RV8
 XOhyKxcfwufCyVKErd7oOuZI30hhZNg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-nnQD54msNZGBYk1ZzdkojA-1; Thu, 20 Aug 2020 06:54:53 -0400
X-MC-Unique: nnQD54msNZGBYk1ZzdkojA-1
Received: by mail-wr1-f72.google.com with SMTP id s23so520707wrb.12
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 03:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4UWgLqombtRgUjlrWroJfuMntbtaAZTLGT5j9WAlzqI=;
 b=p6c9F4XNKTgb1Oz1A+oTS99BIUpq8RgP2WKYyZDFA+lj/fC5rlDXyMP2iKPvNi6bhs
 NsNefb0xwhtF13ky31k21aU7C2TECXathdQSYDJ5QfVjm427h1LYgWTp46YxLOO9dK4s
 qfIgQXNyi9JnLXAahn9ydrdvGKKRiBIBmrMdB8ozYGY24fb/WryRNqI4IPmsWUH9VaCP
 0zYRQmZMKn3lKZEWr9r5hXC4l2vE7AsroFpFm8TLRu33nubGpOMnFb8pm33AQVkY0GH9
 n8qqZMJHcC9s9K5jt4GkVUhU3U8D7VQ5hD9NEnIbSKC3FaeR5audUSkeB2s3o1QfRX0Z
 kiSg==
X-Gm-Message-State: AOAM533bXOFO9g5fwWLmbr/kKnvuy4/AXD6wm0HXBaUZT63eYg1VBhfQ
 8u237pMR3qRVkQ7c1P6ypBststRaRYEKaMMb7L0OJ/oVns8TvpnTRPdDq6ruOLAaP6baYqUXYUe
 jbKREOj4PWcan54g=
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr2928991wmk.86.1597920891893; 
 Thu, 20 Aug 2020 03:54:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKMoS4qyd5AjyaTPjNAL0DZdSlRldlYWLQll6l37bflpu0Wlsqatrob9AvUF1FgGvQ25IGMQ==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr2928975wmk.86.1597920891584; 
 Thu, 20 Aug 2020 03:54:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id o2sm3720137wrh.70.2020.08.20.03.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 03:54:50 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] audio/jack: fix use after free segfault
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <20200819062940.52774-1-geoff@hostfission.com>
 <5029913.bOW1W81TKx@silver>
 <20200820053728.kv7pngxqzp32uky3@sirius.home.kraxel.org>
 <3140676.b1PlGooJ8z@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
Date: Thu, 20 Aug 2020 12:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3140676.b1PlGooJ8z@silver>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 12:06, Christian Schoenebeck wrote:
> Hmmm, as Geoffrey already added a lock today, I noticed that QEMU's main IO 
> thread mutex is not initialized as 'recursive' lock type. Does that make 
> sense? I.e. shouldn't there be a
> 
> 	qemu_rec_mutex_init(&qemu_global_mutex);
> 
> in softmmu/cpus.c for safety reasons to prevent nested locks from same thread 
> causing misbehaviour?
> 
> CCing Paolo to clarify.

atexit functions (in this case
audio_cleanup->free_audio_state->qjack_fini_out) might be called both
with or without the BQL taken, so v7 of this series is likely wrong as
you point out.

However, recursive locks are pure evil. :)

More seriously: programming with concurrency is first and foremost about
understanding invariants[1].  Locks are relatively simple to reason
about because they enforce invariants at the points where they are
acquired or released.

If you have something like

static void do_it_locked(struct foo *foo)
{
    /* ... */
}

static void do_it(struct foo *foo)
{
    mutex_lock(&foo->lock);
    do_it_locked(foo);
    mutex_unlock(&foo->lock);
}

then you can immediately know that foo_locked() calls requires more
care, because the invariants around "foo" have to be provided by the
caller of foo_locked().  Instead, on a call to foo() the invariants are
guaranteed just because the caller must not have locked foo().

Instead, recursive locks allow you to slip into a different mindset
where locks protect the _code_ instead of the _data_ (and the invariants
of that data).  Things look simpler because you can just have

static void do_it(struct foo *foo)
{
    rec_mutex_lock(&foo->lock);
    /* ... */
    rec_mutex_unlock(&foo->lock);
}

but callers have no clue about what invariants are provided around calls
to do_it().  So, understanding complex code that uses recursive mutexes
is effectively impossible.

More on the practical side, recursive mutex are an easy way to get a
deadlock.  It's a common idiom to do

    /* Need to take foo->lock outside bar->lock.  */
    mutex_unlock(&bar->lock);
    mutex_lock(&foo->lock);
    mutex_lock(&bar->lock);

With a recursive mutex, there's no guarantee that foo->lock is *really*
taken outside bar->lock, because the first unlock could have done
nothing except decreasing the lock-nesting count.  This is also why QEMU
uses differently-named functions to lock/unlock recursive mutexes,
instead of having a flag like pthread mutexes do; it makes code like
this stand out as wrong:

    /* Meant to take foo->lock outside bar->lock, but really doesn't  */
    rec_mutex_unlock(&bar->lock);
    mutex_lock(&foo->lock);
    rec_mutex_lock(&bar->lock);

A variant of this applies to callbacks: the golden rule is that
callbacks (e.g. from a function that iterates over a data structure)
should be called without any lock taken in order to avoid deadlocks.
However, this rule is most often ignored in code that uses a recursive
mutex, because that code is written around the (incorrect) paradigm that
mutual exclusion makes code safe.  Which technically is true in this
case, as deadlocks are not a safety problem, but that's not a great
consolation.

My suggestion is to work towards protecting the audio code with its own
mutex(es) and ignore the existence of the BQL for subsystems that can do
so (audio is a prime candidate).  Also please add comments to
audio_int.h about which functions are called from other threads than the
QEMU main thread.

Thanks,

Paolo

[1] https://lamport.azurewebsites.net/pubs/teaching-concurrency.pdf


