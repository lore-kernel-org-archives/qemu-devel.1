Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7811DC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B91214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tk43jUaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B91214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04ig-0001KS-FN
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j04gs-0006uR-Vb
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j04gr-0001KC-Mc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j04gr-0001Jy-IM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581085985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iRgXc6jQr0WqNyPK+74WRYS/+1l/8613GhCECT0naw=;
 b=Tk43jUafbWcGyVMv/ljUzTwjZJKmEMMET3voTvr0HZQFLZz19+/sjuF7FkalKDVdoy75Uu
 shzUzNBZWP4W6CzETs7u3LEaZju7UsqO5OJ5qQ1YA8Ngf+jegO0bE+qEqDNv4KNhhiWMd2
 qf5HS3c5z+oXqFSILrdyWfLyGGuvaHU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-6Eo43kniMe6Io1wG_hFwjQ-1; Fri, 07 Feb 2020 09:33:03 -0500
Received: by mail-wm1-f71.google.com with SMTP id b202so778573wmb.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FbBeDKAU04DWOP0hVqG1KKcgrpic8GudeGNHpNcR4hM=;
 b=Zu6iLJlyd99J0uxTdVvDbjCZ2js2xNDtN0pR2/SOFayWw0HnZUo8mCaD3bIEZqI75o
 qyE6OqSAswwtuCilJluPssblEKwVB01Kb8GITxwoC4Du+a4kD08ZJM2L4jA+epSKe5g+
 zcQjQe8V0swk7IvIhMJhUhz6FsprNBlwNEBTsaLuTvZkhbmtT7q826KMvtcfyD9C9Opk
 hk2v554DPjoATthnAVbzLTYQ91c+EL/r15Xnd/aVHL/1gL4D5MUP0gqkH8p3X5ptCkf2
 CcLv2KNV7GdJSTuQHBzlP1N9NirOZc7CNo0okjqkbP1V7fW7hNhLVc9613Kf/ECt2U0J
 GbzQ==
X-Gm-Message-State: APjAAAWWHIMHDUSJM0gfNNzUfl0HHuWFom2GquXw8jCxriPiVGObWe3o
 MfMMQrvj3nhpZa4xrijZHumMmWI4aVUY72O1YltxZyzTXDN+SX/QIqhsqUfXwSvlyOEeCFEjg5h
 EnVlSwomcEdLWuVg=
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr4749999wmk.49.1581085981577; 
 Fri, 07 Feb 2020 06:33:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGphGnAcsyVhDmXRqc1qmgt7O3bvoCJIPn/SYYPpeQGZRCXt+UbXZb2QzTPc0aeMaeCgXQeA==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr4749974wmk.49.1581085981289; 
 Fri, 07 Feb 2020 06:33:01 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g7sm3575881wrq.21.2020.02.07.06.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:33:00 -0800 (PST)
Subject: Re: [PATCH v2 10/29] python/qemu: Add
 binutils::binary_get_qom_implementations()
To: Liam Merwick <liam.merwick@oracle.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-11-philmd@redhat.com>
 <4d8b1927-8b2e-efa9-c116-4aa61462d6c2@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <83b581d4-dd24-aa17-c06b-a6eef539139d@redhat.com>
Date: Fri, 7 Feb 2020 15:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4d8b1927-8b2e-efa9-c116-4aa61462d6c2@oracle.com>
Content-Language: en-US
X-MC-Unique: 6Eo43kniMe6Io1wG_hFwjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 3:28 PM, Liam Merwick wrote:
> On 29/01/2020 21:23, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since QEMU binaries can be built with various configurations,
>> the list of QOM objects linked can vary.
>> Add a helper to query the list of all QOM types implementing a
>> particular interface.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 python/qemu/binutils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 ++++++++++++++++++++
>> =C2=A0 tests/acceptance/core_scripts.py | 10 ++++++++++
>> =C2=A0 2 files changed, 30 insertions(+)
>>
>> diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
>> index 7bb57c521b..76f256f5d2 100644
>> --- a/python/qemu/binutils.py
>> +++ b/python/qemu/binutils.py
>> @@ -66,3 +66,23 @@ def binary_get_machines(qemu_bin):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOG.info(res)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.shutdown()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return [m['name']=
 for m in res]
>> +
>> +def binary_get_qom_implementations(qemu_bin, type_name,=20
>> include_abstract=3DFalse):
>> +=C2=A0=C2=A0=C2=A0 '''
>> +=C2=A0=C2=A0=C2=A0 Get list of QOM types implementing a particular inte=
rface
>> +
>> +=C2=A0=C2=A0=C2=A0 @param qemu_bin (str): path to the QEMU binary
>> +=C2=A0=C2=A0=C2=A0 @param type_name (str): QOM interface name
>> +=C2=A0=C2=A0=C2=A0 @param include_abstract (bool): if True, abstract in=
terfaces are=20
>> also
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 returned=
 in the list
>> +=C2=A0=C2=A0=C2=A0 @return list of QOM types implementing the interface=
 @type_name
>> +=C2=A0=C2=A0=C2=A0 '''
>> +=C2=A0=C2=A0=C2=A0 with QEMUMachine(qemu_bin) as vm:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.set_machine('none')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D vm.command('qom-list=
-types',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 implements=3Dtype_name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 abstract=3Dinclude_abstract)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOG.info(res)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.shutdown()
>=20
>=20
> Based on Wainer's comment on patch3 - is this vm.shutdown() needed?

Nop.

>=20
> otherwise
>=20
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Thanks :)

>=20
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return [m['name'] for m in r=
es]
>> diff --git a/tests/acceptance/core_scripts.py=20
>> b/tests/acceptance/core_scripts.py
>> index a5b112f928..c2fe4acf1d 100644
>> --- a/tests/acceptance/core_scripts.py
>> +++ b/tests/acceptance/core_scripts.py
>> @@ -18,6 +18,7 @@=20
>> sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',=20
>> 'python'))
>> =C2=A0 from avocado_qemu import Test
>> =C2=A0 from qemu.binutils import binary_get_arch
>> =C2=A0 from qemu.binutils import binary_get_machines
>> +from qemu.binutils import binary_get_qom_implementations
>> =C2=A0 from qemu.binutils import binary_get_version
>> @@ -49,3 +50,12 @@ class PythonQemuCoreScripts(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 logger.debug('machine: {}'.format(m))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # The 'none' mach=
ine is always available
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn('no=
ne', machines)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_get_qom_implementation(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger =3D logging.getLogger=
('core')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_name =3D "accel"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_impl =3D binary_get_qom=
_implementations(self.qemu_bin,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 type_name, True)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for t in type_impl:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logg=
er.debug('type: {}'.format(t))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn(type_name, typ=
e_impl)
>>
>=20


