Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CCEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2C9222E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBL4fYLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2C9222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrIX-0005ir-OD
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQrH4-0005BQ-SI
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQrH2-0007L3-0L
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AQJHSB84I6PETOSXivNB8t83axxDrlguEkBQu5Eic78=;
 b=aBL4fYLMPte7Nhdo8TS6ZXYfo9KcurQEjNinOf5Yw1Db3xs6rXSJ0HnarQ3I9mwPy3K1cV
 b/Fl3aI0Sez7pwNDYSoiDWFPQ24A92hIF6S0FJvvodr+PbWvnQbEYnnoYcX06cqHdJ7zHu
 RsA9AdKn5zx//Z4X/RIEDhpPiKqFUCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-Q2t-qa24M-GGJZHIy54Wsw-1; Fri, 09 Oct 2020 08:13:17 -0400
X-MC-Unique: Q2t-qa24M-GGJZHIy54Wsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BCC0100670B;
 Fri,  9 Oct 2020 12:13:16 +0000 (UTC)
Received: from [10.3.113.14] (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C913819936;
 Fri,  9 Oct 2020 12:13:13 +0000 (UTC)
Subject: Re: [PATCH v3 2/6] nbd: Add 'qemu-nbd -A' to expose allocation depth
To: "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20201009020714.1074061-1-eblake@redhat.com>
 <20201009020714.1074061-3-eblake@redhat.com>
 <87lfgfom51.fsf@dusky.pond.sub.org> <20201009090338.GE30079@redhat.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <ab63b4f3-529d-d690-5507-2f35282b3f0e@redhat.com>
Date: Fri, 9 Oct 2020 07:13:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009090338.GE30079@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3v5zd1CJYvJhgYTl7Ph84HdwDgtGhphZv"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3v5zd1CJYvJhgYTl7Ph84HdwDgtGhphZv
Content-Type: multipart/mixed; boundary="qoxgB3jmnCsAJBo2YrbctPTHK6CgaDuJW";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Message-ID: <ab63b4f3-529d-d690-5507-2f35282b3f0e@redhat.com>
Subject: Re: [PATCH v3 2/6] nbd: Add 'qemu-nbd -A' to expose allocation depth
References: <20201009020714.1074061-1-eblake@redhat.com>
 <20201009020714.1074061-3-eblake@redhat.com>
 <87lfgfom51.fsf@dusky.pond.sub.org> <20201009090338.GE30079@redhat.com>
In-Reply-To: <20201009090338.GE30079@redhat.com>

--qoxgB3jmnCsAJBo2YrbctPTHK6CgaDuJW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/9/20 4:03 AM, Richard W.M. Jones wrote:

>>> +++ b/qapi/block-core.json
>>> @@ -3882,9 +3882,12 @@
>>>  #
>>>  # @tls-creds: TLS credentials ID
>>>  #
>>> -# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place=
 of
>>> +# @x-dirty-bitmap: A metacontext name such as "qemu:dirty-bitmap:NAME"=
 or
>>
>> What is a "metacontext"?
>>
>> Aside: nbd.h spells it "meta context".  The two spellings suggest
>> different meanings to me.  Using meta- as a prefix modifies the prefixed
>> word, as in metadata (data that provides information about other data).
>> Separated by space, meta becomes a noun.  None of its common meanings
>> seem to apply here.  Recommend to pick an appropriate one of
>> "metacontext", "meta-context", "meta context", and stick to it.
>=20
> In the NBD protocol it's called a "metadata context".  This is
> abbreviated to "...META_CONTEXT" in the names of constants,
> eg. NBD_OPT_SET_META_CONTEXT.  For the reasons you gave I don't think
> it's a very good name, but it's what we have.
>=20
> https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md#metada=
ta-querying
>=20
> What it actually is, is a string, like "base:allocation" or
> "qemu:dirty-bitmap:<NAME>" which selects which metadata you want to
> query in NBD_CMD_BLOCK_STATUS commands.

Sounds like documenting it as a "metadata context name" is probably the
one to use then. I'll make that adjustment.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--qoxgB3jmnCsAJBo2YrbctPTHK6CgaDuJW--

--3v5zd1CJYvJhgYTl7Ph84HdwDgtGhphZv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl+AU9gACgkQp6FrSiUn
Q2pY1Af/aG2UhBXTd3O7ckZD6+My3yrqVvIi4DqKq1KlqxMCRCCRE6MC2pnrya/L
NTHhn6m9S5K/NYoqzUJK5AmAV2ycMU7K4QLFQuRhIxXEdD6f4sDTBIbgDl6jBxWO
nLZE2mKcBuDM+o8hQttmfe7/6EoVwSdVrpTBpmasfGFuq28hKpdgNfLB3OlF1eju
9NJz+2AnMUnS1PMSidbZm5L+ekgrAgiVa36yT22I3h2TTdppc56L0ZHN/MtYHi1T
GPM6EB0mlUtgQG154Aw8Q93iwRhY90fGHp+TiUMkqHfnQbXPtekLT11T1ZpgHK3R
Tr3Z787oXsfj02qutYXWWjTdmyX1Yw==
=uICS
-----END PGP SIGNATURE-----

--3v5zd1CJYvJhgYTl7Ph84HdwDgtGhphZv--


