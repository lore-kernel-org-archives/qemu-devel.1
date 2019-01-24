Received: from eggs.gnu.org ([209.51.188.92]:41842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gma6Q-0005s1-OO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gma6P-0002TY-Qx
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:11:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gma6P-0002SA-D0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:11:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0O84X9k088121
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:11:07 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q78u4t5yh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:11:06 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 24 Jan 2019 08:11:04 -0000
References: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
	<1544135058-21380-3-git-send-email-walling@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 24 Jan 2019 09:11:00 +0100
MIME-Version: 1.0
In-Reply-To: <1544135058-21380-3-git-send-email-walling@linux.ibm.com>
Content-Language: en-US
Message-Id: <e688a276-4ea5-4edc-fda1-4153acb50bb4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390: cpu feature for diagnose 318
 andlimit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, thuth@redhat.com



On 06.12.2018 23:24, Collin Walling wrote:
> Diagnose 318 is a new z14.2 CPU feature. Since we are able to emulate
> it entirely via KVM, we can add guest support for earlier models. A
> new CPU feature for diagnose 318 (shortened to diag318) will be made
> available to guests starting with the zEC12-full CPU model.
> 
> The z14.2 adds a new read SCP info byte (let's call it byte 134) to
> detect the availability of diag318. Because of this, we have room for
> one less VCPU and thus limit the max VPUs supported in a configuration
> to 247 (down from 248).
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>.
> ---
>  hw/s390x/sclp.c                 | 2 ++
>  include/hw/s390x/sclp.h         | 2 ++
>  target/s390x/cpu.h              | 2 +-
>  target/s390x/cpu_features.c     | 3 +++
>  target/s390x/cpu_features.h     | 1 +
>  target/s390x/cpu_features_def.h | 3 +++
>  target/s390x/gen-features.c     | 1 +
>  target/s390x/kvm.c              | 1 +
>  8 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 4510a80..183c627 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -73,6 +73,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>                           read_info->conf_char);
>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>                           read_info->conf_char_ext);
> +    /* Read Info byte 134 */
> +    s390_get_feat_block(S390_FEAT_TYPE_SCLP_BYTE_134, read_info->byte_134);
>  
>      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
>                                          SCLP_HAS_IOA_RECONFIG);
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index f9db243..eb12ba2 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -133,6 +133,8 @@ typedef struct ReadInfo {
>      uint16_t highest_cpu;
>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>      uint32_t hmfai;
> +    uint8_t  _reserved7[134 - 128];     /* 128-133 */
> +    uint8_t  byte_134[1];
>      struct CPUEntry entries[0];
>  } QEMU_PACKED ReadInfo;
 
The size must be a multiple of 16. Can you add a reserved field to fill up
until 144?
