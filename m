Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B974EC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849182073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+khCbmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849182073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieHJU-0005Q0-Kf
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieHIk-0004q4-JT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieHIh-0003dE-MO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:34:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42648
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieHIh-0003bv-G6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575891242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=EY/fATiPKDkm8fDu5FGZAKmXxcDIJLthd9cEYLWDags=;
 b=N+khCbmB9/ClawUmgTm18qtWhy4AHnU7BjN/7NAVjNgpAWId8hbEAJjkG2h2Q5Oa5yXsXH
 mJDJneunnc1GoDTSG8N6ZfDTK5aeRSMdAc6DyJOl6sXAlNFsME/J+MVXiekvcLFWuutw9z
 QqaG0kncm51ZzW2KP/hyjbyvM3DFogY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-x3_krS9mMOWEcL8Cu48nvw-1; Mon, 09 Dec 2019 06:34:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248BA107ACC5
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 11:34:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADEA41001B03;
 Mon,  9 Dec 2019 11:33:56 +0000 (UTC)
Subject: Re: [PATCH 2/2] net: Drop the NetLegacy structure, always use Netdev
 instead
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20191206053640.29368-1-thuth@redhat.com>
 <20191206053640.29368-3-thuth@redhat.com>
 <bac8635c-b38c-51e0-2478-ec14d96aedbb@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9f69161b-69f3-0dc6-59d0-54441fe664e2@redhat.com>
Date: Mon, 9 Dec 2019 12:33:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bac8635c-b38c-51e0-2478-ec14d96aedbb@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: x3_krS9mMOWEcL8Cu48nvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/12/2019 16.14, Eric Blake wrote:
> On 12/5/19 11:36 PM, Thomas Huth wrote:
>> Now that the "name" parameter is gone, there is hardly any difference
>> between NetLegacy and Netdev anymore. Drop NetLegacy and always use
>> Netdev to simplify the code quite a bit.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>=20
> Initial focus on the QAPI change:
>=20
>> +++ b/qapi/net.json
>> @@ -467,7 +467,7 @@
>> =C2=A0 # 'l2tpv3' - since 2.1
>> =C2=A0 ##
>> =C2=A0 { 'union': 'Netdev',
>> -=C2=A0 'base': { 'id': 'str', 'type': 'NetClientDriver' },
>> +=C2=A0 'base': { '*id': 'str', 'type': 'NetClientDriver' },
>=20
> Making id optional here...
>=20
>> =C2=A0=C2=A0=C2=A0 'discriminator': 'type',
>> =C2=A0=C2=A0=C2=A0 'data': {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'nic':=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'Net=
LegacyNicOptions',
>> @@ -481,55 +481,6 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'netmap':=C2=A0=C2=A0 'NetdevNetmapOption=
s',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vhost-user': 'NetdevVhostUserOptions' } =
}
>> =C2=A0 -##
>> -# @NetLegacy:
>> -#
>> -# Captures the configuration of a network device; legacy.
>> -#
>> -# @id: identifier for monitor commands
>> -#
>> -# @opts: device type specific properties (legacy)
>> -#
>> -# Since: 1.2
>> -#
>> -# 'vlan': dropped in 3.0
>> -# 'name': dropped in 5.0
>> -##
>> -{ 'struct': 'NetLegacy',
>> -=C2=A0 'data': {
>> -=C2=A0=C2=A0=C2=A0 '*id':=C2=A0=C2=A0 'str',
>> -=C2=A0=C2=A0=C2=A0 'opts':=C2=A0 'NetLegacyOptions' } }
>=20
> to match how it was here.=C2=A0 Should 'id' have been made mandatory in 1=
/2,
> when deleting 'name' (after all, id was optional only when name was in
> use)?

No, since "id" is still not mandatory for "-net". In case it is missing,
the code creates an id internally (see assign_name() in net/net.c).

>> -
>> -##
>> -# @NetLegacyOptionsType:
>> -#
>> -# Since: 1.2
>> -##
>> -{ 'enum': 'NetLegacyOptionsType',
>> -=C2=A0 'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde'=
,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'bridge', =
'netmap', 'vhost-user'] }
>=20
> Comparing this to the branches of Netdev:
>=20
> We are losing 'none', while gaining 'hubport'.=C2=A0 The gain is not
> problematic, and I guess you are declaring that the use of 'none' has
> been deprecated long enough to not be a problem.

'none' still continues to work, it's also a member of NetClientDriver
and was handled later in the patch:

+        if (netdev->type =3D=3D NET_CLIENT_DRIVER_NONE) {
             return 0; /* nothing to do */

'hubport' is blocked in the code now instead:

+        if (netdev->type =3D=3D NET_CLIENT_DRIVER_HUBPORT ||
+            !net_client_init_fun[netdev->type]) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
                        "a net backend type (maybe it is not compiled "
                        "into this binary)");

>> -
>> -##
>> -# @NetLegacyOptions:
>> -#
>> -# Like Netdev, but for use only by the legacy command line options
>> -#
>> -# Since: 1.2
>> -##
>> -{ 'union': 'NetLegacyOptions',
>> -=C2=A0 'base': { 'type': 'NetLegacyOptionsType' },
>> -=C2=A0 'discriminator': 'type',
>> -=C2=A0 'data': {
>> -=C2=A0=C2=A0=C2=A0 'nic':=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'NetLegacyNicOp=
tions',
>=20
> Should we rename this to NetdevNicOptions, now that we are getting rid
> of other NetLegacy names?

I still consider "-net nic" as a legacy option that we should remove one
day in the future, so I'd rather keep that name.

>=20
> But I concur that all branches of the Netdev union have the same types
> as what you are removing here from NetLegacyOptions, so the
> consolidation looks sane.

Ok, thanks for your review!

 Thomas


