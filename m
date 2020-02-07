Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FFAC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D05214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWU9JOUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D05214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04dE-00024V-IP
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j04c9-0000gK-T5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j04c8-0003RH-Ax
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:28:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j04c8-0003Lk-3F
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:28:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017ES957052290;
 Fri, 7 Feb 2020 14:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cKNgBV1r7Z2Mkv2xnevHRkYunGF5cmVkVaSRz7LzOkE=;
 b=CWU9JOUzkifxUy43KJykf3IFgE6yIFc36SJpE4Lm04Av8PGFAWMrcpTHYAn+5csPUg59
 KM7rOOTf17BCExvNAcBuasOy8bEcGjsKZnmZra5ZLPeRLHSGK86qmiblw9YBmev74S0D
 dgfJbmOctRj3Y9GKSbSP9WuD/b5Gw6oijVyQsRA8WIWvbdGkdqjFLDp3Onplw6wbkrmm
 ++1qFHtpoaj3V4T1WqztUJaQwScXj4tPdHrqh5WN+xUvSQLEjrFOhGtj/ewv42FMKMyB
 Z0hsvtKeTx152DlD4u2L5y2W6bCPE8TMrKTGmgzX1OP0LfXjjFhMIAnJWm3u+W0boBBA fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2xykbpga9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 14:28:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017EJfMX001125;
 Fri, 7 Feb 2020 14:28:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2y0mk1x6wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 14:28:09 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 017ES8T2031417;
 Fri, 7 Feb 2020 14:28:08 GMT
Received: from [10.175.208.183] (/10.175.208.183)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Feb 2020 06:28:07 -0800
Subject: Re: [PATCH v2 10/29] python/qemu: Add
 binutils::binary_get_qom_implementations()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-11-philmd@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <4d8b1927-8b2e-efa9-c116-4aa61462d6c2@oracle.com>
Date: Fri, 7 Feb 2020 14:28:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070111
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 017ES957052290
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
> Since QEMU binaries can be built with various configurations,
> the list of QOM objects linked can vary.
> Add a helper to query the list of all QOM types implementing a
> particular interface.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   python/qemu/binutils.py          | 20 ++++++++++++++++++++
>   tests/acceptance/core_scripts.py | 10 ++++++++++
>   2 files changed, 30 insertions(+)
>=20
> diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
> index 7bb57c521b..76f256f5d2 100644
> --- a/python/qemu/binutils.py
> +++ b/python/qemu/binutils.py
> @@ -66,3 +66,23 @@ def binary_get_machines(qemu_bin):
>           LOG.info(res)
>           vm.shutdown()
>           return [m['name'] for m in res]
> +
> +def binary_get_qom_implementations(qemu_bin, type_name, include_abstra=
ct=3DFalse):
> +    '''
> +    Get list of QOM types implementing a particular interface
> +
> +    @param qemu_bin (str): path to the QEMU binary
> +    @param type_name (str): QOM interface name
> +    @param include_abstract (bool): if True, abstract interfaces are a=
lso
> +                                    returned in the list
> +    @return list of QOM types implementing the interface @type_name
> +    '''
> +    with QEMUMachine(qemu_bin) as vm:
> +        vm.set_machine('none')
> +        vm.launch()
> +        res =3D vm.command('qom-list-types',
> +                         implements=3Dtype_name,
> +                         abstract=3Dinclude_abstract)
> +        LOG.info(res)
> +        vm.shutdown()


Based on Wainer's comment on patch3 - is this vm.shutdown() needed?

otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> +        return [m['name'] for m in res]
> diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_s=
cripts.py
> index a5b112f928..c2fe4acf1d 100644
> --- a/tests/acceptance/core_scripts.py
> +++ b/tests/acceptance/core_scripts.py
> @@ -18,6 +18,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__=
), '..', '..', 'python'))
>   from avocado_qemu import Test
>   from qemu.binutils import binary_get_arch
>   from qemu.binutils import binary_get_machines
> +from qemu.binutils import binary_get_qom_implementations
>   from qemu.binutils import binary_get_version
>  =20
>  =20
> @@ -49,3 +50,12 @@ class PythonQemuCoreScripts(Test):
>               logger.debug('machine: {}'.format(m))
>           # The 'none' machine is always available
>           self.assertIn('none', machines)
> +
> +    def test_get_qom_implementation(self):
> +        logger =3D logging.getLogger('core')
> +        type_name =3D "accel"
> +        type_impl =3D binary_get_qom_implementations(self.qemu_bin,
> +                                                   type_name, True)
> +        for t in type_impl:
> +            logger.debug('type: {}'.format(t))
> +        self.assertIn(type_name, type_impl)
>=20


