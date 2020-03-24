Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9E6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CA020775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBisBEGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CA020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGko0-0005ag-Sa
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGknJ-00051X-AL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGknI-0003b3-AD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:44:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGknI-0003ad-6w
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585061079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r2ulnfOW5In9Al+PJ6mw2g7xnPOu+wY2l0y2Thwgtg=;
 b=SBisBEGVz7O/fLu6CadWuSN0q1voGQcqPCi19n2GJxVbFf8nFEAliJ0DlCV6MbwSlP7psL
 KlL8znpWCIHZ5BdeBEVXT3KoYb5spYESkbVoX/6Lz69Y/YQGnwD3oHOe5weFhEdF+6D66D
 u7zEBHws3nXVZ/u34l0kVWlCIPJKzPg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-846NkxuENnS4wmp3X8_k-w-1; Tue, 24 Mar 2020 10:44:38 -0400
X-MC-Unique: 846NkxuENnS4wmp3X8_k-w-1
Received: by mail-ed1-f69.google.com with SMTP id g7so8614952edm.20
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vLTYHRVc7sUn009ahZTAmS31grnVbH8+9oNIKgjnQRo=;
 b=nN6sC17UN0fb5f5EF6v1UDdlfhUZNkThMgFwWcI4HTdMwr0+Fl+6kRN1OJkTHsk7gh
 EYtPbVngDeoFYxFhUUZxTVZ8ULCSHAPsJEtsqT0MMRi5YoK/LxFoi39QjCHiTbaZbrfd
 vaQrlHY4zDXBUYefcpCMeX2DYKDQb66BRNmKYMoRvZ94h2CCy4nT+NntA1rFjP0ExOUR
 NWJhQnidbnjhVkuaHHX8+3gN67LTWIzUbQOHBOJERu0jZlq2aPyID+dDDpUECr0wLRIx
 zT/BRntnti8PQWqZErJg+ypx2u1QXNCT9s74oBmKKZQG8I5sLl+e9BHw1XlVEclRaILg
 B4OQ==
X-Gm-Message-State: ANhLgQ0AbL9wrLSQZ8dWnjQzR2oD1My/onpIc7mYNXGM8SRzy28uuoEq
 gKt8Jpv+aA96NL+wsQZctQgrWT+Vkd9SbJVztAQgI7utRAhmxkBfA8jXoUTR1UBaP6jzAv72rNT
 vX7ON53WWieIs2E0=
X-Received: by 2002:a50:d657:: with SMTP id c23mr26404889edj.18.1585061076947; 
 Tue, 24 Mar 2020 07:44:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsc/MjlyheE0+Ug7pj97UsqCuO/Z5psNUk8bU/Y8ttTaqxGPohF4bQTc9C7Zj/ZGJYAe2wfww==
X-Received: by 2002:a50:d657:: with SMTP id c23mr26404864edj.18.1585061076721; 
 Tue, 24 Mar 2020 07:44:36 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d23sm1102562ejk.26.2020.03.24.07.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 07:44:36 -0700 (PDT)
Subject: Re: [PATCH] nvme: Print 'cqid' for nvme_del_cq
To: Minwoo Im <minwoo.im.dev@gmail.com>, qemu-block@nongnu.org
References: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8750804d-5c5b-203a-00d1-9126f04999aa@redhat.com>
Date: Tue, 24 Mar 2020 15:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 3:06 PM, Minwoo Im wrote:
> The given argument for this trace should be cqid, not sqid.
>=20
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>   hw/block/trace-events | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index f78939fa9da1..bf6d11b58b85 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -37,7 +37,7 @@ nvme_rw(const char *verb, uint32_t blk_count, uint64_t =
byte_count, uint64_t lba)
>   nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qs=
ize, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
>   nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t =
size, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx64=
", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu=
16", ien=3D%d"
>   nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
> -nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
> +nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=3D%"PRIu16""
>   nvme_identify_ctrl(void) "identify controller"
>   nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
>   nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PR=
Iu16""
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


