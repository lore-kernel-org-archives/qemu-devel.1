Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DB8C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBE82084D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jF6GNZQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBE82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMl1-0007zP-Kq
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMkW-0007aO-7P
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMkV-0005QH-3n
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:38:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hdMkU-0005P5-Me
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:38:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMXkMi096658;
 Tue, 18 Jun 2019 22:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WqGcra+x5jYUz+XeUgk6o28zhSVfwy8g6C/Lwb6TJN4=;
 b=jF6GNZQe6cKMXeB6lOcJxoPb/CYnCZ0RH0F8k8M7nPO78kuSfhgFAMii3WU+0X00Bd/9
 1dx1LN+m9IBZWx+n2gUXgKiEfkyuH2MHscCoFp+dwuU49EEb1F5b+VTSj+LNRoTnP24f
 ISRVEFuZwiQkH5pCQnetxxcU6ZIkwCGIg+71gXTvFm+dXo35oaN1CwFrYMvKCGNyJJBO
 X0qzXDTtjjjxoy+NO/CpGh2Zcs/e/vuKstyUBvTWeTDgTFGnBXiQNKFjYBrmB60mxnvq
 qHU0Xf4tZvijx/mbCv+L4/MO1sBNd/pOCR74YNM6+dex1BJzhPOG/2DGTcT9KDo/xTFB gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t780985dx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:38:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMbamr054032;
 Tue, 18 Jun 2019 22:38:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t77ymrnrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:38:39 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5IMccZI010683;
 Tue, 18 Jun 2019 22:38:38 GMT
Received: from [10.141.197.71] (/10.141.197.71)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Jun 2019 15:38:38 -0700
To: Paolo Bonzini <pbonzini@redhat.com>, Liran Alon <liran.alon@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-4-pbonzini@redhat.com>
 <EB7EDEC6-BD44-460E-B7B2-29060631E4FF@oracle.com>
 <0144E234-98F2-4D05-B2AB-8DA23E418D46@oracle.com>
 <74FC0FAA-54DE-4E72-90F5-32B0551F1D83@oracle.com>
 <c281bf78-2753-effb-fb23-31600e272723@redhat.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <363a4b01-4538-f45d-3d09-d9206b419587@oracle.com>
Date: Tue, 18 Jun 2019 15:38:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c281bf78-2753-effb-fb23-31600e272723@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180181
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 x5IMXkMi096658
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH 3/7] KVM: i386: Add support for
 KVM_CAP_EXCEPTION_PAYLOAD
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
Cc: qemu-devel@nongnu.org, Nikita Leshenko <nikita.leshchenko@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/2019 10:27 AM, Paolo Bonzini wrote:
> On 17/06/19 13:34, Liran Alon wrote:
>> Putting this all together, in case kernel doesn=E2=80=99t support extr=
acting
>> nested-state, there is no decent way to know if guest is running
>> nested-virtualization. Which means that in theory we always need to
>> fail migration in case kernel doesn=E2=80=99t support KVM_CAP_NESTED_S=
TATE or
>> KVM_CAP_EXCEPTION_PAYLOAD and vCPU is exposed with VMX/SVM
>> capability.
> For VMX this would be okay because we had a blocker before this series,
> and this wouldn't be any worse.

I agree it shouldn't be a gating issue for this patch series, but I'd=20
hate to see this discussion thread die off.

I'm still pretty interested in hearing whether anyone has any good ideas=20
for how to conclusively determine whether a given L1 VM has created a=20
nested L2 or not when the host is running an older Kernel that doesn't=20
support KVM_CAP_NESTED_STATE. That would be a very useful capability,=20
especially for CSP use cases. If anyone has any suggestions about where=20
to look, I don't mind spending some time digging into it and possibly=20
testing out a few ideas. Again, separate from this particular patch=20
series. So far I've been drawing a blank after Liran pointed out that=20
corner case problems associated with env->cr[4] & CR4_VMXE_MASK.

Thanks,
-Maran

> For SVM we can ignore the case and fix it when we have
> KVM_CAP_NESTED_STATE, as again that wouldn't be any worse.
>
> Paolo
>
>> I can condition this behaviour with a flag that can be manipulated
>> using QMP to allow user to indicate it wishes to migrate guest anyway
>> in this case. This however bring me back to the entire discussion I
>> had with Dr. David Alan Gilbert on migration backwards compatibility
>> in general and the fact that I believe we should have a generic QMP
>> command which allows to provide list of VMState subsections that can
>> be ignored in migration=E2=80=A6 See:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg622274.html
>>
>> Paolo, What are your thoughts on how I would proceed with this?


