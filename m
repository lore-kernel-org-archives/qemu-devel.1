Received: from eggs.gnu.org ([2001:4830:134:3::10]:43366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eC301-0008Md-EQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eC2zy-0007JQ-Nh
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:29:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39286
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eC2zy-0007Iy-Hk
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:28:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7CPJ41021033
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 07:28:51 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3b2axqe3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:28:50 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 07:28:49 -0500
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510016336-4086-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 7 Nov 2017 07:28:47 -0500
MIME-Version: 1.0
In-Reply-To: <1510016336-4086-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <0c3b89cc-a5cf-6765-5a03-1d0380d28b9c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] tpm: tpm_passthrough: Read the buffer
 size from the host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com

On 11/06/2017 07:58 PM, Stefan Berger wrote:
> Rather than hard coding the buffer size in the tpm_passthrough
> backend read the TPM I/O buffer size from the host device.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>   hw/tpm/tpm_int.h         |   9 ++++
>   hw/tpm/tpm_passthrough.c |  11 ++++-
>   hw/tpm/tpm_util.c        | 116 +++++++++++++++++++++++++++++++++++++++++++++++
>   hw/tpm/tpm_util.h        |   3 ++
>   4 files changed, 138 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index 1df5883..f838535 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -45,11 +45,20 @@ struct tpm_resp_hdr {
>
>   #define TPM_ORD_ContinueSelfTest  0x53
>   #define TPM_ORD_GetTicks          0xf1
> +#define TPM_ORD_GetCapability     0x65
>
> +#define TPM_CAP_PROPERTY          0x05
> +
> +#define TPM_CAP_PROP_INPUT_BUFFER 0x124
>
>   /* TPM2 defines */
>   #define TPM2_ST_NO_SESSIONS       0x8001
>
>   #define TPM2_CC_ReadClock         0x00000181
> +#define TPM2_CC_GetCapability     0x0000017a
> +
> +#define TPM2_CAP_TPM_PROPERTIES   0x6
> +
> +#define TPM2_PT_INPUT_BUFFER      0x10d
>
>   #endif /* TPM_TPM_INT_H */
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 7ff9249..ec755fe 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -57,6 +57,7 @@ struct TPMPassthruState {
>       int cancel_fd;
>
>       TPMVersion tpm_version;
> +    uint32_t tpm_buffersize;
>   };
>
>   typedef struct TPMPassthruState TPMPassthruState;
> @@ -201,7 +202,15 @@ static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
>
>   static uint32_t tpm_passthrough_get_buffer_size(TPMBackend *tb)
>   {
> -    return 4096;
> +    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
> +    int ret;
> +
> +    ret = tpm_util_get_buffer_size(tpm_pt->tpm_fd, tpm_pt->tpm_version,
> +                                   &tpm_pt->tpm_buffersize);
> +    if (ret < 0) {
> +        tpm_pt->tpm_buffersize = 4096;
> +    }
> +    return tpm_pt->tpm_buffersize;
>   }
>
>   /*
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 396e793..3c861ab 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -20,10 +20,19 @@
>    */
>
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "tpm_util.h"
>   #include "tpm_int.h"
>   #include "exec/memory.h"
>
> +#define DEBUG_TPM 0
> +
> +#define DPRINTF(fmt, ...) do { \
> +    if (DEBUG_TPM) { \
> +        fprintf(stderr, "tpm-util:"fmt"\n", ## __VA_ARGS__); \
> +    } \
> +} while (0)
> +
>   /*
>    * Write an error message in the given output buffer.
>    */
> @@ -170,3 +179,110 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version)
>
>       return 1;
>   }
> +
> +int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
> +                             uint32_t *buffersize)
> +{
> +    unsigned char buf[1024];
> +    const struct tpm_req_get_buffer_size {
> +        struct tpm_req_hdr hdr;
> +        uint32_t capability;
> +        uint32_t len;
> +        uint32_t subcap;
> +    } QEMU_PACKED tpm_get_buffer_size = {
> +        .hdr = {
> +            .tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> +            .len = cpu_to_be32(sizeof(tpm_get_buffer_size)),
> +            .ordinal = cpu_to_be32(TPM_ORD_GetCapability),
> +        },
> +        .capability = cpu_to_be32(TPM_CAP_PROPERTY),
> +        .len = cpu_to_be32(sizeof(uint32_t)),
> +        .subcap = cpu_to_be32(TPM_CAP_PROP_INPUT_BUFFER),
> +    };
> +    const struct tpm2_req_get_buffer_size {
> +        struct tpm_req_hdr hdr;
> +        uint32_t capability;
> +        uint32_t property;
> +        uint32_t count;
> +    } QEMU_PACKED tpm2_get_buffer_size = {
> +        .hdr = {
> +            .tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> +            .len = cpu_to_be32(sizeof(tpm2_get_buffer_size)),
> +            .ordinal = cpu_to_be32(TPM2_CC_GetCapability),
> +        },
> +        .capability = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES),
> +        .property = cpu_to_be32(TPM2_PT_INPUT_BUFFER),

I have to fix this to TPM_PT_MAX_COMMAND_SIZE (0x11e) and 
TPM_PT_MAX_RESPONSE_SIZE (0x11f) and take the maximum of the two.

     Stefan

> +        .count = cpu_to_be32(1),
> +    };
> +    struct tpm_resp_get_buffer_size {
> +        struct tpm_resp_hdr hdr;
> +        uint32_t len;
> +        uint32_t buffersize;
> +    } QEMU_PACKED *tpm_resp = (struct tpm_resp_get_buffer_size *)buf;
> +    struct tpm2_resp_get_buffer_size {
> +        struct tpm_resp_hdr hdr;
> +        uint8_t more;
> +        uint32_t capability;
> +        uint32_t count;
> +        uint32_t property;
> +        uint32_t value;
> +    } QEMU_PACKED *tpm2_resp = (struct tpm2_resp_get_buffer_size *)buf;
> +    unsigned char *request = NULL;
> +    size_t requestlen;
> +    int ret;
> +
> +    switch (tpm_version) {
> +    case TPM_VERSION_1_2:
> +        request = (unsigned char *)&tpm_get_buffer_size;
> +        requestlen = sizeof(tpm_get_buffer_size);
> +        break;
> +    case TPM_VERSION_2_0:
> +        request = (unsigned char *)&tpm2_get_buffer_size;
> +        requestlen = sizeof(tpm2_get_buffer_size);
> +        break;
> +    case TPM_VERSION_UNSPEC:
> +        return -EFAULT;
> +    }
> +
> +    ret = tpm_util_tx(tpm_fd, request, requestlen, buf, sizeof(buf));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    switch (tpm_version) {
> +    case TPM_VERSION_1_2:
> +        if (be32_to_cpu(tpm_resp->hdr.len) != sizeof(*tpm_resp) ||
> +            be32_to_cpu(tpm_resp->len) != sizeof(uint32_t)) {
> +            DPRINTF("tpm_resp->hdr.len = %u, expected = %zu\n",
> +                    be32_to_cpu(tpm_resp->hdr.len), sizeof(*tpm_resp));
> +            DPRINTF("tpm_resp->len = %u, expected = %zu\n",
> +                    be32_to_cpu(tpm_resp->len), sizeof(uint32_t));
> +            error_report("tpm_util: Got malformed response to "
> +                         "TPM_GetCapability; errcode: 0x%x",
> +                         be32_to_cpu(tpm_resp->hdr.errcode));
> +            return -EFAULT;
> +        }
> +        *buffersize = be32_to_cpu(tpm_resp->buffersize);
> +        break;
> +    case TPM_VERSION_2_0:
> +        if (be32_to_cpu(tpm2_resp->hdr.len) != sizeof(*tpm2_resp) ||
> +            be32_to_cpu(tpm2_resp->count) != 1) {
> +            DPRINTF("tpm2_resp->hdr.len = %u, expected = %zu\n",
> +                    be32_to_cpu(tpm2_resp->hdr.len), sizeof(*tpm2_resp));
> +            DPRINTF("tpm2_resp->len = %u, expected = %u\n",
> +                    be32_to_cpu(tpm2_resp->count), 1);
> +            error_report("tpm_util: Got malformed response to "
> +                         "TPM2_GetCapability; errcode: 0x%x",
> +                         be32_to_cpu(tpm2_resp->hdr.errcode));
> +            return -EFAULT;
> +        }
> +        *buffersize = be32_to_cpu(tpm2_resp->value);
> +        break;
> +    case TPM_VERSION_UNSPEC:
> +        break;
> +    }
> +
> +    DPRINTF("buffersize of device: %u\n", *buffersize);
> +
> +    return 0;
> +}
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index aca10c9..e4fba32 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -36,4 +36,7 @@ static inline uint32_t tpm_cmd_get_size(const void *b)
>       return be32_to_cpu(*(const uint32_t *)(b + 2));
>   }
>
> +int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
> +                             uint32_t *buffersize);
> +
>   #endif /* TPM_TPM_UTIL_H */
