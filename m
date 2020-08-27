Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FADC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400F72087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLSkOw/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400F72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKmA-0003EB-IA
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kBKlV-0002gu-BB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:28:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kBKlT-0000TE-84
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598545717;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3UERZT3c7QF566OpHv640Lpo81x63HtGYmIvBBeQKo=;
 b=XLSkOw/IqkqXquwUOmz6SVz1TUj6EQ3XRPwHu0/xZnOH9m7YNctcbymyQkpTenj20Ht6Ig
 hJkp7m+kY+SPBLmK0V/0xYakN+7cKGjP+AZYTyynOWon6g3UX9M2JGDUEsMlIbKZ/rvZKA
 YUAUOYsZniFtKuLxbASyYiyb8gUfgv0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-sLQXjEEgPbiIYJDlNUSI3w-1; Thu, 27 Aug 2020 12:28:36 -0400
X-MC-Unique: sLQXjEEgPbiIYJDlNUSI3w-1
Received: by mail-wr1-f70.google.com with SMTP id w2so1701670wrr.19
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 09:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N3UERZT3c7QF566OpHv640Lpo81x63HtGYmIvBBeQKo=;
 b=YXSlvE0EE9+nx1Uk3I6eCXmB7flRWqSN6LApka4X4HEJsws4WH/d2kcqoD8m1qppey
 PrVJSBcTuk3TRtGimtNF+sn0OHbI+kiBTTpIoxB0E1kP3ykp16bx2JLTf9xOnFhrcQC5
 uuPmqnF2uw7wUSj7fXcbspznrB7ZZgnotDBKbip3c3WW43nujuFI2LWxldi78nwVFc+t
 YEFf+OlUfBXdBBRlN3UmqSOcSCtTR+8pEAfePFXjzRHLGyix2U2dtI7WXARroYYZyS4e
 LojMDxyMW7A0ruW3LS2Wb3e432WEgEJBQVjqb8V6hUhLYxB9mEfFHfH4jKTPHwWgW/cx
 /vSQ==
X-Gm-Message-State: AOAM5331M+CyQSk2e7k4w+JTKgaYw1U6iH8CTKgCuCQ0KcXyfwO73/sl
 aloxcRAYwU71SdoorWWNHgKMhx55N4F1hfwsPF/8WEhPN/1BPNmyuBbMAKeEV2S1dnR4r9ldlZ0
 lg53l1o+4e6Vsv6g=
X-Received: by 2002:a05:600c:514:: with SMTP id
 i20mr12868948wmc.102.1598545712026; 
 Thu, 27 Aug 2020 09:28:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0VcNqEc/h/RHFDO+X3rcWwI54XZlWZd4YeHwYZVGcE9g1pKWXIaad2+GLkGDMjMv/JgUHcg==
X-Received: by 2002:a05:600c:514:: with SMTP id
 i20mr12868941wmc.102.1598545711833; 
 Thu, 27 Aug 2020 09:28:31 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id f6sm7196383wro.5.2020.08.27.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 09:28:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH] test-vmstate: fix bad GTree usage, use-after-free
In-Reply-To: <20200827161826.1165971-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Thu, 27 Aug 2020 20:18:26 +0400")
References: <20200827161826.1165971-1-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 27 Aug 2020 18:28:30 +0200
Message-ID: <878se0xdch.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: quintela@redhat.com
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> According to g_tree_foreach() documentation:
> "The tree may not be modified while iterating over it (you can't
> add/remove items)."
>
> Fixes: 9a85e4b8f6 ("migration: Support gtree migration")
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


