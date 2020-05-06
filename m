Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C746C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2323920675
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSPPA3mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2323920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFeq-0003Za-Bq
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWFe0-0002jr-9E
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:43:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWFdy-0000Xi-Qz
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588754585;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4Q6wjM479ADP0N3s+V2akFFvcb3uQCkKOSt88RzA8U=;
 b=LSPPA3mNG0ZMmBw8oL+DHBNEEuQ7moJxQPiAUOf+e3LH0rCPw9cUZNoYnm3f5wYiqz7dL8
 bgGlb/tiiiTCKaKQKYMZUqN2Errx6AOTOdahBZryPiLly6xbMYpJgprnD1MQsyDOMFkQYL
 1YSfquQa+vur3ZMyrJfoUzMsJRQCj8Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-EAvnTE1nPhCvAAP6tIG62A-1; Wed, 06 May 2020 04:43:03 -0400
X-MC-Unique: EAvnTE1nPhCvAAP6tIG62A-1
Received: by mail-wr1-f69.google.com with SMTP id p2so945577wrx.12
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 01:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=A2bvA70APm2TA4MjkdIrjG6haffPhoETju58lovz3FU=;
 b=hn1mLWs3CbLXeO99CTGkh1cEEWoKjzLhsLIPJTeLYpyRTCLuPafzryXO1uz0lTOUWa
 bjb+S7Jyya6ooNfW+lh8aKpBEMxv2sGRSLivioavTNyp3nPm2aaFZZ7S3dHw+mZ4JRMZ
 QxzZNN5KUw/fadKgZ03i9/a/p3Oq9gKeBP7IOStepG6AZN34oihlXb7gJMpbI9oNk/I6
 5ESMz0Bw830fpgS2q42gHPhf8KWieqzbzl2vcZMi/LDBdxy1P/QepLfE2v9FOuRVYyP2
 7hB62Onq2KS+fV+7b+5nHujDpUOguoKuzzA+Gz2b3JpfEDdXEG6uShm/q6wA2E72MRP6
 DlUg==
X-Gm-Message-State: AGi0PuaQJ/46x/BgqRLMPcvU6TKliIGmzjFkyPVuRhklgAzWgTjee0wq
 PWJOiqtqzYM6N/90UOfgD9tck6HCGbTOWTMNRHAbo8/3uzkzp1gQ57jfArvf9fOiwGAJHg6BtZU
 x+5f1mjzly+JCU4U=
X-Received: by 2002:adf:fccc:: with SMTP id f12mr8036244wrs.267.1588754582608; 
 Wed, 06 May 2020 01:43:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypImrv60Tgac1y73IT3dKH4MrSG8eTkeQzs0n7cnO8DcZNBi1cSo98Y82o4y7YCxJ84JNK0xnw==
X-Received: by 2002:adf:fccc:: with SMTP id f12mr8036230wrs.267.1588754582424; 
 Wed, 06 May 2020 01:43:02 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id w4sm1601484wro.28.2020.05.06.01.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:43:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 2/2] migration/multifd: Do error_free after
 migrate_set_error to avoid memleaks
In-Reply-To: <20200506095416.26099-3-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Wed, 6 May 2020 05:54:16 -0400")
References: <20200506095416.26099-1-pannengyuan@huawei.com>
 <20200506095416.26099-3-pannengyuan@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 06 May 2020 10:43:01 +0200
Message-ID: <87zhalihd6.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: zhang.zhanghailiang@huawei.com, euler.robot@huawei.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> wrote:
> When error happen in multifd_send_thread, it use error_copy to set migrat=
e error in
> multifd_send_terminate_threads(). We should call error_free after it.
>
> Similarly, fix another two places in multifd_recv_thread/multifd_save_cle=
anup.
>
> The leak stack:
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7f781af07cf0 in calloc (/lib64/libasan.so.5+0xefcf0)
>     #1 0x7f781a2ce22d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5322d)
>     #2 0x55ee1d075c17 in error_setv /mnt/sdb/backup/qemu/util/error.c:61
>     #3 0x55ee1d076464 in error_setg_errno_internal /mnt/sdb/backup/qemu/u=
til/error.c:109
>     #4 0x55ee1cef066e in qio_channel_socket_writev /mnt/sdb/backup/qemu/i=
o/channel-socket.c:569
>     #5 0x55ee1cee806b in qio_channel_writev /mnt/sdb/backup/qemu/io/chann=
el.c:207
>     #6 0x55ee1cee806b in qio_channel_writev_all /mnt/sdb/backup/qemu/io/c=
hannel.c:171
>     #7 0x55ee1cee8248 in qio_channel_write_all /mnt/sdb/backup/qemu/io/ch=
annel.c:257
>     #8 0x55ee1ca12c9a in multifd_send_thread /mnt/sdb/backup/qemu/migrati=
on/multifd.c:657
>     #9 0x55ee1d0607fc in qemu_thread_start /mnt/sdb/backup/qemu/util/qemu=
-thread-posix.c:519
>     #10 0x7f78159ae2dd in start_thread (/lib64/libpthread.so.0+0x82dd)
>     #11 0x7f78156df4b2 in __GI___clone (/lib64/libc.so.6+0xfc4b2)
>
> Indirect leak of 52 byte(s) in 1 object(s) allocated from:
>     #0 0x7f781af07f28 in __interceptor_realloc (/lib64/libasan.so.5+0xeff=
28)
>     #1 0x7f78156f07d9 in __GI___vasprintf_chk (/lib64/libc.so.6+0x10d7d9)
>     #2 0x7f781a30ea6c in g_vasprintf (/lib64/libglib-2.0.so.0+0x93a6c)
>     #3 0x7f781a2e7cd0 in g_strdup_vprintf (/lib64/libglib-2.0.so.0+0x6ccd=
0)
>     #4 0x7f781a2e7d8c in g_strdup_printf (/lib64/libglib-2.0.so.0+0x6cd8c=
)
>     #5 0x55ee1d075c86 in error_setv /mnt/sdb/backup/qemu/util/error.c:65
>     #6 0x55ee1d076464 in error_setg_errno_internal /mnt/sdb/backup/qemu/u=
til/error.c:109
>     #7 0x55ee1cef066e in qio_channel_socket_writev /mnt/sdb/backup/qemu/i=
o/channel-socket.c:569
>     #8 0x55ee1cee806b in qio_channel_writev /mnt/sdb/backup/qemu/io/chann=
el.c:207
>     #9 0x55ee1cee806b in qio_channel_writev_all /mnt/sdb/backup/qemu/io/c=
hannel.c:171
>     #10 0x55ee1cee8248 in qio_channel_write_all /mnt/sdb/backup/qemu/io/c=
hannel.c:257
>     #11 0x55ee1ca12c9a in multifd_send_thread /mnt/sdb/backup/qemu/migrat=
ion/multifd.c:657
>     #12 0x55ee1d0607fc in qemu_thread_start /mnt/sdb/backup/qemu/util/qem=
u-thread-posix.c:519
>     #13 0x7f78159ae2dd in start_thread (/lib64/libpthread.so.0+0x82dd)
>     #14 0x7f78156df4b2 in __GI___clone (/lib64/libc.so.6+0xfc4b2)
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


