Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65652C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C42E206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C42E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfzZ-0001kd-BZ
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jCfyn-0000t6-6O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jCfyh-0004SS-L6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:47:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46412
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jCfyh-0004P7-EQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:47:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02D8YiMr037248
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 04:47:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yqyjb6cdn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 04:47:34 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Fri, 13 Mar 2020 08:47:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 08:47:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02D8lRtx46727282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 08:47:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CAB94C052;
 Fri, 13 Mar 2020 08:47:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF4654C050;
 Fri, 13 Mar 2020 08:47:26 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.119])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 08:47:26 +0000 (GMT)
Subject: Re: [PATCH RFCv2 2/4] intc/s390_flic_kvm.c: Use kvm_device_ioctl()
 instead of ioctl()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200312161217.3590-1-david@redhat.com>
 <20200312161217.3590-3-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Fri, 13 Mar 2020 09:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312161217.3590-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031308-0016-0000-0000-000002F05DAB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031308-0017-0000-0000-00003353D016
Message-Id: <278da424-0956-8095-c357-1cd69c4f8396@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-11,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130048
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12.03.20 17:12, David Hildenbrand wrote:
> Let's use the official variant, which will e.g., trace the call.
> kvm_device_ioctl() will do the rc -> -errno conversion automatically, so
> we can drop that code.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  hw/intc/s390_flic_kvm.c | 43 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index a306b26faa..ce05306406 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -66,11 +66,8 @@ static int flic_get_all_irqs(KVMS390FLICState *flic,
>          .addr = (uint64_t) buf,
>          .attr = len,
>      };
> -    int rc;
>  
> -    rc = ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr);
> -
> -    return rc == -1 ? -errno : rc;
> +    return kvm_device_ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr);
>  }
>  
>  static void flic_enable_pfault(KVMS390FLICState *flic)
> @@ -78,11 +75,8 @@ static void flic_enable_pfault(KVMS390FLICState *flic)
>      struct kvm_device_attr attr = {
>          .group = KVM_DEV_FLIC_APF_ENABLE,
>      };
> -    int rc;
> -
> -    rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  
> -    if (rc) {
> +    if (kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr)) {
>          fprintf(stderr, "flic: couldn't enable pfault\n");
>      }
>  }
> @@ -92,11 +86,8 @@ static void flic_disable_wait_pfault(KVMS390FLICState *flic)
>      struct kvm_device_attr attr = {
>          .group = KVM_DEV_FLIC_APF_DISABLE_WAIT,
>      };
> -    int rc;
>  
> -    rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
> -
> -    if (rc) {
> +    if (kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr)) {
>          fprintf(stderr, "flic: couldn't disable pfault\n");
>      }
>  }
> @@ -111,16 +102,13 @@ static void flic_disable_wait_pfault(KVMS390FLICState *flic)
>  static int flic_enqueue_irqs(void *buf, uint64_t len,
>                              KVMS390FLICState *flic)
>  {
> -    int rc;
>      struct kvm_device_attr attr = {
>          .group = KVM_DEV_FLIC_ENQUEUE,
>          .addr = (uint64_t) buf,
>          .attr = len,
>      };
>  
> -    rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
> -
> -    return rc ? -errno : 0;
> +    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
>  static void kvm_s390_inject_flic(S390FLICState *fs, struct kvm_s390_irq *irq)
> @@ -187,7 +175,6 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
>                             uint16_t subchannel_nr)
>  {
>      KVMS390FLICState *flic = s390_get_kvm_flic(fs);
> -    int rc;
>      uint32_t sid = subchannel_id << 16 | subchannel_nr;
>      struct kvm_device_attr attr = {
>          .group = KVM_DEV_FLIC_CLEAR_IO_IRQ,
> @@ -197,8 +184,7 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
>      if (unlikely(!flic->clear_io_supported)) {
>          return -ENOSYS;
>      }
> -    rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
> -    return rc ? -errno : 0;
> +    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
>  static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
> @@ -218,7 +204,7 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
>          return -ENOSYS;
>      }
>  
> -    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
> +    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
>  static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
> @@ -235,7 +221,7 @@ static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
>          return -ENOSYS;
>      }
>  
> -    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
> +    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
>  /**
> @@ -285,7 +271,6 @@ static int kvm_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
>          .flags = flags,
>      };
>      KVMS390FLICState *flic = KVM_S390_FLIC(fs);
> -    int r;
>      struct kvm_device_attr attr = {
>          .group = KVM_DEV_FLIC_ADAPTER_REGISTER,
>          .addr = (uint64_t)&adapter,
> @@ -296,9 +281,7 @@ static int kvm_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
>          return 0;
>      }
>  
> -    r = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
> -
> -    return r ? -errno : 0;
> +    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
>  static int kvm_s390_io_adapter_map(S390FLICState *fs, uint32_t id,
> @@ -314,15 +297,13 @@ static int kvm_s390_io_adapter_map(S390FLICState *fs, uint32_t id,
>          .addr = (uint64_t)&req,
>      };
>      KVMS390FLICState *flic = s390_get_kvm_flic(fs);
> -    int r;
>  
>      if (!kvm_gsi_routing_enabled()) {
>          /* nothing to do */
>          return 0;
>      }
>  
> -    r = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
> -    return r ? -errno : 0;
> +    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
>  static int kvm_s390_add_adapter_routes(S390FLICState *fs,
> @@ -519,7 +500,7 @@ static int kvm_flic_ais_post_load(void *opaque, int version_id)
>          return -ENOSYS;
>      }
>  
> -    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
> +    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
>  static const VMStateDescription kvm_s390_flic_ais_tmp = {
> @@ -636,9 +617,9 @@ static void kvm_s390_flic_reset(DeviceState *dev)
>          }
>      }
>  
> -    rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
> +    rc = kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>      if (rc) {
> -        trace_flic_reset_failed(errno);
> +        trace_flic_reset_failed(-rc);
>      }
>  
>      flic_enable_pfault(flic);
> 


