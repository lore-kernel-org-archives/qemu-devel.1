Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE473C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799162072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AB8FqotT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799162072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIhB-0001a7-Mr
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jiIeM-0005Vw-IH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:21:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jiIeL-00053z-LD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591626076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7WaGYc4YqMfv7zWQW/ryPvlzud45mNtQgivlhLwvUE=;
 b=AB8FqotTMRvk+qqrSr3CB+2dLTifEWwLM4lgtowNkNbeokzqFJQM1JWUXjivl0w806BfkB
 WDrcfqv+G0i2rSHAML4dFbIcJLFRlmFvfgv1pdGjckKzWr23gOQeRg66PdtNPEgdwsThhr
 ugclUEFZ60kNNm7eJnCSHCSDnHeR6Gc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-8Jx9EjjTPKW_2fd8l4-BDw-1; Mon, 08 Jun 2020 10:21:14 -0400
X-MC-Unique: 8Jx9EjjTPKW_2fd8l4-BDw-1
Received: by mail-ed1-f71.google.com with SMTP id n17so7018194eda.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=i7WaGYc4YqMfv7zWQW/ryPvlzud45mNtQgivlhLwvUE=;
 b=bOB0XF0GgPnc3xRq477afv0LyJXwDYiEaevc6j/lD4KJ2zx73ad+wPGxj0q/9pEE4t
 f4W0wn5zPczRM/nCD2ZBSJUz/slPyCVYyWOUDzIiZgQKAe87SR0HO4WQkjF+5n5KDRkh
 uxuJqOd0mcJ3Cc/Gkv19WTE8WNE93IaZQzNoqqhBrLptnFajbays1kfoY+PiEYBLf+vy
 aOez3cZ+WSlZACK7W66gNkKdRmFhfq1P2KKdwzh6acdspuMgLWI9a08dpc6d4IXk8JT5
 hq5eMy1GHV2KNPy04s2wPDDuyXGLS+zOSS+FwlIm35Nadp4CBBJkDBBf/N3juDweh1qp
 9t+w==
X-Gm-Message-State: AOAM530MyShgss6FKajhBvUsYwHrhXaEweYcBjZ+n2Gdv7HPutDJQaF7
 avnlGwIAaQPSjZ8ktSKVwWxR8RlzXPmTPmKeVAbAwLed+uI8glze8rgBT4PiKB21ffyYF3RVjp0
 s/vdKcX0mapM30tw=
X-Received: by 2002:a17:906:971a:: with SMTP id
 k26mr19596329ejx.230.1591626073717; 
 Mon, 08 Jun 2020 07:21:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjIQFNFvHnlHoCsLTh1Al//ia5VjFU83IDdns4CPjhtX68yvyrx00C7cOgxarUjMP7IlFUrQ==
X-Received: by 2002:a17:906:971a:: with SMTP id
 k26mr19596309ejx.230.1591626073533; 
 Mon, 08 Jun 2020 07:21:13 -0700 (PDT)
Received: from ?IPv6:2a01:598:898d:54fb:a5ae:42ea:c579:c82b?
 ([2a01:598:898d:54fb:a5ae:42ea:c579:c82b])
 by smtp.gmail.com with ESMTPSA id r1sm10731883eja.57.2020.06.08.07.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:21:12 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] hmp: Make json format optional for qom-set
Date: Mon, 8 Jun 2020 16:21:11 +0200
Message-Id: <1B4C55FD-0356-4027-95ED-4A006004B94F@redhat.com>
References: <652a6692-2ba4-94b0-503d-9cea876c859c@redhat.com>
In-Reply-To: <652a6692-2ba4-94b0-503d-9cea876c859c@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: iPhone Mail (17E262)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "=?utf-8?Q? Daniel_P._Berrang=C3=A9 ?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 08.06.2020 um 16:16 schrieb Paolo Bonzini <pbonzini@redhat.com>:
>=20
> =EF=BB=BFOn 08/06/20 16:06, David Hildenbrand wrote:
>>     {
>>         .name       =3D "qom-set",
>> -        .args_type  =3D "path:s,property:s,value:S",
>> -        .params     =3D "path property value",
>> -        .help       =3D "set QOM property",
>> +        .args_type  =3D "json:-j,path:s,property:s,value:s",
>=20
> I think this should remain an uppercase "S", so that it grabs the rest
> of the input rather than stop at the first space.
>=20

Yes, changed by mistake (while working on a revert). Thanks!

> Paolo
>=20
>> +        .params     =3D "[-j] path property value",
>> +        .help       =3D "set QOM property.\n\t\t\t"
>> +                      "-j: the property is specified in json format.",
>>         .cmd        =3D hmp_qom_set,
>>         .flags      =3D "p",
>>     },
>> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
>=20


