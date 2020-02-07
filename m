Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B042C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5624624683
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xfLomaQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5624624683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Hn-0001Bw-Gj
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j0594-0002R2-5m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j0590-0006Cv-6a
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:02:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j058z-0006BJ-TI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:02:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017EwSxc099448;
 Fri, 7 Feb 2020 15:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=imsXEeQsTs8Seqvx1e4QL9U98/yAZDSawoBKBg/SOuU=;
 b=xfLomaQX4/FwvMkEnpXfe0bO8hOtlg5L3eBfLQf8PhCNKmUZQD1BRXdwggi4+u25BYnu
 HTPYqvBCJvz+UPpe36huj9eZ+v7/DdekCbqpeH/A36IIDdo8HIan6pNSv+8K3shPcsZy
 yKCSVyVU1kDENwAG/pzBbtZbYMl38yVeIJQplzeT59dexVHGum5U5On9iJj8O1qGefam
 K2x0hODKO4U4k6Mzv4+204PtUwtM2EDi0wYM6LCEl07UbwiuWgUFy3LN1OW1isN1DnFy
 wZaOnIaMlMUDd3FWiBeyMtqsWmxV4fKprw396X9SCGLWCWB+9x2l+eUP8b28MNzv+ARS Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2xykbpggge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 15:02:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017Exk4I171635;
 Fri, 7 Feb 2020 15:02:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2y16pqvfm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 15:02:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 017F25Mf022165;
 Fri, 7 Feb 2020 15:02:05 GMT
Received: from [10.175.208.183] (/10.175.208.183)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Feb 2020 07:02:05 -0800
Subject: Re: [PATCH v2 13/29] python/qemu: Add binutils::binary_get_devices()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-14-philmd@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <137e055e-2c8b-ba2b-d13e-6b9a0d9b13ac@oracle.com>
Date: Fri, 7 Feb 2020 15:02:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-14-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070116
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 017EwSxc099448
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
> the list of devices linked in can vary.
> Add a helper to query the list of devices built into a
> QEMU binary.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   python/qemu/binutils.py          | 9 +++++++++
>   tests/acceptance/core_scripts.py | 8 ++++++++
>   2 files changed, 17 insertions(+)
>=20
> diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
> index bba203bc8d..9633ba8efd 100644
> --- a/python/qemu/binutils.py
> +++ b/python/qemu/binutils.py
> @@ -96,3 +96,12 @@ def binary_get_accels(qemu_bin):
>       '''
>       accel_types =3D binary_get_qom_implementations(qemu_bin, "accel",=
 False)
>       return [a.strip("-accel") for a in accel_types]
> +
> +def binary_get_devices(qemu_bin):
> +    '''
> +    Get list of devices supported by a QEMU binary
> +
> +    @param qemu_bin (str): path to the QEMU binary
> +    @return list of devices supported by the binary
> +    '''
> +    return binary_get_qom_implementations(qemu_bin, "device", False)
> diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_s=
cripts.py
> index 7380f2f49b..a62eb2e46b 100644
> --- a/tests/acceptance/core_scripts.py
> +++ b/tests/acceptance/core_scripts.py
> @@ -18,6 +18,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__=
), '..', '..', 'python'))
>   from avocado_qemu import Test
>   from qemu.binutils import binary_get_accels
>   from qemu.binutils import binary_get_arch
> +from qemu.binutils import binary_get_devices
>   from qemu.binutils import binary_get_machines
>   from qemu.binutils import binary_get_qom_implementations
>   from qemu.binutils import binary_get_version
> @@ -69,3 +70,10 @@ class PythonQemuCoreScripts(Test):
>           self.assertNotIn("accel", accels)
>           # qtest is always available
>           self.assertIn("qtest", accels)
> +
> +    def test_get_devices(self):
> +        logger =3D logging.getLogger('core')
> +        devices =3D binary_get_devices(self.qemu_bin)
> +        for d in devices:
> +            logger.debug('device: {}'.format(d))
> +        self.assertIn("migration", devices)
>=20


