Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422BC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5327214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZeYLLjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5327214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j054u-0002MQ-4L
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j04jA-0003Cz-Pr
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j04j9-0005XS-6A
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:35:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j04j8-0005Qj-OR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:35:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017EXGP1067546;
 Fri, 7 Feb 2020 14:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B8PVcbP3bBpEhORUmyZnXmoHhEO6R7TMcrqUXa8Rg7U=;
 b=mZeYLLjnbNwUYnWqI+ghaZHoBW0z15My8c2kzWT4CT4g79XkzkUqfnUGJgfCikYdyFTm
 h5Zm7KeNC8ecpo7Dcfiyy+y2sHT9iaUapEYc67OIix9GWbsMPI6DcMVGx/3/VLI15IPg
 kUr1+Qba/mM6adpxqBJr6SU5vFjyw8zIylUl+s2Am5apGjbIdjHt0r/earfHHaIW3RgK
 +4qkrQ+RcoZHR5AJyGqdtH27rvdShstV6ONVHk9m6CjAlAGXIKQ1AGreb9yTQ5wuPe/d
 bw+yXcNUEi3RgE+NdSZv4p2U597js+B5sQyzVPwxqRRQRugyXrimf8O2cmmSwaGIa+be Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2xykbprcum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 14:35:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017EXnBk023306;
 Fri, 7 Feb 2020 14:35:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2y0jg1kaqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 14:35:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 017EZL62026814;
 Fri, 7 Feb 2020 14:35:21 GMT
Received: from [10.175.208.183] (/10.175.208.183)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Feb 2020 06:35:21 -0800
Subject: Re: [PATCH v2 11/29] python/qemu: Add binutils::binary_get_accels()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-12-philmd@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <7d543b28-0c1b-7524-849f-764f4e0e69ce@oracle.com>
Date: Fri, 7 Feb 2020 14:35:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070112
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 017EXGP1067546
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

On 29/01/2020 21:23, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a helper to query the list of accelerators built into a
> QEMU binary.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   python/qemu/binutils.py          | 10 ++++++++++
>   tests/acceptance/core_scripts.py | 10 ++++++++++
>   2 files changed, 20 insertions(+)
>=20
> diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
> index 76f256f5d2..bba203bc8d 100644
> --- a/python/qemu/binutils.py
> +++ b/python/qemu/binutils.py
> @@ -86,3 +86,13 @@ def binary_get_qom_implementations(qemu_bin, type_na=
me, include_abstract=3DFalse):
>           LOG.info(res)
>           vm.shutdown()
>           return [m['name'] for m in res]
> +
> +def binary_get_accels(qemu_bin):
> +    '''
> +    Get list of accelerators supported by a QEMU binary
> +
> +    @param qemu_bin (str): path to the QEMU binary
> +    @return list of accelerators supported by the binary
> +    '''
> +    accel_types =3D binary_get_qom_implementations(qemu_bin, "accel", =
False)
> +    return [a.strip("-accel") for a in accel_types]
> diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_s=
cripts.py
> index c2fe4acf1d..7380f2f49b 100644
> --- a/tests/acceptance/core_scripts.py
> +++ b/tests/acceptance/core_scripts.py
> @@ -16,6 +16,7 @@ import logging
>  =20
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', '=
python'))
>   from avocado_qemu import Test
> +from qemu.binutils import binary_get_accels
>   from qemu.binutils import binary_get_arch
>   from qemu.binutils import binary_get_machines
>   from qemu.binutils import binary_get_qom_implementations
> @@ -59,3 +60,12 @@ class PythonQemuCoreScripts(Test):
>           for t in type_impl:
>               logger.debug('type: {}'.format(t))
>           self.assertIn(type_name, type_impl)
> +
> +    def test_get_accels(self):
> +        logger =3D logging.getLogger('core')
> +        accels =3D binary_get_accels(self.qemu_bin)
> +        for a in accels:
> +            logger.debug('accel: {}'.format(a))
> +        self.assertNotIn("accel", accels)
> +        # qtest is always available
> +        self.assertIn("qtest", accels)
>=20


