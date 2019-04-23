Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96143C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA7E218DA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OrFlJhOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA7E218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2xC-0007yE-K0
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:27:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1hJ2wH-0007bM-Hx
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1hJ2wF-0002jB-Ae
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:26:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1hJ2wF-0002g3-0Q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:26:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3NLNhlp077364; Tue, 23 Apr 2019 21:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=FWfc68/RA1Jow+RAkXaOpeW/nlgwVN07AMeWr+Gxx10=;
	b=OrFlJhOcSHK+++QNV+TYF6m9bGh1bPH1IXkJ5qmlEfSQkNLtHpTvxlYKvytvN28o6iLl
	Epgpz57TLew8g0gl0gsDTKDCObe8Y36gZYsBmCVJvxaBgv9OpzVHAr4AvRWkaCP/PBV0
	IuttEPaSHAQYJ5WlNVx6Lq0YkrGmMPTJxdB4qs67byEccfI+ncMR8fRJt7wQcJ4bEFnV
	AeIeF7c8PHeRZpkF1FeKlxXcy7fgLvm2zBDANNNJKXcTgzCEtxmxTXB7CYoyWGyAjPG6
	A7zWsc2cAao6Yl0PxyZPLPY43XxhP3hIA345rv9PUlkK+XfNc4b82tNmvHyseNPfbKlB
	Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2rytusxtr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2019 21:26:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3NLQXTd019217; Tue, 23 Apr 2019 21:26:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2s0f0vqryv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2019 21:26:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3NLQY5q008906;
	Tue, 23 Apr 2019 21:26:35 GMT
Received: from [10.11.108.55] (/10.11.108.55)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 23 Apr 2019 14:26:34 -0700
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190308095036.GC12318@stefanha-x1.localdomain>
	<20190326080822.GC21018@stefanha-x1.localdomain>
	<e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
	<CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
Date: Tue, 23 Apr 2019 17:26:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904230151
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904230151
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
	x3NLNhlp077364
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
	John G Johnson <john.g.johnson@oracle.com>,
	sstabellini@kernel.org, konrad.wilk@oracle.com,
	qemu-devel@nongnu.org, ross.lagerwall@citrix.com,
	liran.alon@oracle.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423212633.3-oA9OO2WL1EfAQNdew0uim3KMGusSWov6w_feLYxW8@z>



On 3/26/2019 6:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>> Please share the SELinux policy files, containerization scripts, etc.
>>>> There is probably a home for them in qemu.git, libvirt.git, or elsew=
here
>>>> upstream.
>>>>
>>>> We need to find a way to make the sandboxing improvements available =
to
>>>> users besides yourself and easily reusable for developers who wish t=
o
>>>> convert additional device models.
>>
>=20
> Also for testing this series.

Hi,

We are wondering how to deliver the example SELinux policies. I have
posted on Fedora's SELinux mailing list to get info. on how to upstream
SElinux policy.

We are developing SELinux Type Enforcements and MCS labels to sandbox
the emulation process. Details regarding example Type Enforcement is
available below.

We are also working on changes to libvirt, to launch the remote process
and apply MCS labels. Libvirt changes will be posted separately in the
future.

The Type Enforcements for SElinux is available in the pastebin location
below (also copied at the end of this email):
https://pastebin.com/t1bpS6MY

An RPM package which installs this policy as a SELinux module, and
configures the file contexts for the executables, is available for
download in the link below:
http://wikisend.com/download/156700/mpqemu-selinux-example-1.0-1.fc29.noa=
rch.rpm

The README for RPM could be obtained by running the following commands:
# rpm2cpio ./packagecloud-test-1.1-1.x86_64.rpm | cpio -idmv
# cat opt/mpqemu-selinux-example/doc/README

Thanks!
--
Jag


----------
mpqemu.te:
----------

module mpqemu 1.0;


require {
	class process transition;
	class file { execute read };
	class file entrypoint;
	class dir search;
	class file { getattr open read };
	class file { getattr map open read };
	class file { execute map read };
	class lnk_file read;
	class chr_file { lock open read write };
	class file { getattr ioctl lock open read write };
	class process fork;
	class fd use;
	class unix_stream_socket { read write };
	class file open;
	class process { noatsecure rlimitinh siginh };
	class file write;
	class dir { getattr search };
	class file { open read };
	class process getattr;
	type qemu_t;
	type qemu_exec_t;
	type virtd_t;
	type ld_so_cache_t;
	type ld_so_t;
	type lib_t;
	type null_device_t;
	type virt_image_t;
	type shell_exec_t;
	type init_t;
	attribute domain;
	attribute entry_type;
	attribute exec_type;
	attribute application_exec_type;
	attribute file_type, non_security_file_type, non_auth_file_type;
	attribute virt_domain;
	attribute virt_image_type;
=09
};


type qemu_lsi53c895a_exec_t;
type qemu_lsi53c895a_img_t;
type qemu_lsi53c895a_t;

typeattribute qemu_lsi53c895a_t virt_domain;

typeattribute qemu_lsi53c895a_exec_t file_type, non_security_file_type,=20
non_auth_file_type;
typeattribute qemu_lsi53c895a_exec_t exec_type;
typeattribute qemu_lsi53c895a_exec_t application_exec_type;
typeattribute qemu_lsi53c895a_exec_t entry_type;
typeattribute qemu_lsi53c895a_img_t file_type, non_security_file_type,=20
non_auth_file_type;
typeattribute qemu_lsi53c895a_img_t virt_image_type;
type_transition qemu_t qemu_lsi53c895a_exec_t : process qemu_lsi53c895a_t=
;
type_transition virtd_t qemu_exec_t : process qemu_t;

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D init_t =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
allow init_t qemu_lsi53c895a_t:dir search;
allow init_t qemu_lsi53c895a_t:file { getattr open read };

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D qemu_lsi53c895a_t =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
allow qemu_lsi53c895a_t ld_so_cache_t : file { getattr map open read };
allow qemu_lsi53c895a_t ld_so_t : file { execute map read };
allow qemu_lsi53c895a_t lib_t : lnk_file read;
allow qemu_lsi53c895a_t null_device_t : chr_file { lock open read write }=
;
allow qemu_lsi53c895a_t qemu_lsi53c895a_exec_t : file { execute map read =
};
allow qemu_lsi53c895a_t qemu_lsi53c895a_img_t : file { getattr ioctl=20
lock open read write };
allow qemu_lsi53c895a_t self : process fork;
allow qemu_lsi53c895a_t qemu_t : fd use;
allow qemu_lsi53c895a_t qemu_t : unix_stream_socket { read write };
allow qemu_lsi53c895a_t qemu_lsi53c895a_exec_t : file entrypoint;

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D qemu_t =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
allow qemu_t qemu_lsi53c895a_exec_t : file open;
allow qemu_t qemu_lsi53c895a_t : process { noatsecure rlimitinh siginh };
allow qemu_t virt_image_t : file write;
allow qemu_t qemu_lsi53c895a_t : process transition;
allow qemu_t qemu_lsi53c895a_exec_t : file { execute read };

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D virtd_t =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
allow virtd_t shell_exec_t : file entrypoint;



>>> Stefan
>>>
>>
>>

