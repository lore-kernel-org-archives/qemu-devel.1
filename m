Received: from eggs.gnu.org ([2001:4830:134:3::10]:55836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <minwoo.im.dev@gmail.com>) id 1e8TM9-00050l-JB
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 11:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <minwoo.im.dev@gmail.com>) id 1e8TM8-0000Qm-I1
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 11:49:05 -0400
MIME-Version: 1.0
In-Reply-To: <20171023161825.GE10220@stefanha-x1.localdomain>
References: <1508568856-17545-1-git-send-email-minwoo.im.dev@gmail.com>
	<20171023161825.GE10220@stefanha-x1.localdomain>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Sun, 29 Oct 2017 00:48:58 +0900
Message-ID: <CAA7jztcUcrLbQJtkfRrBsg2ZWEZucq+ra4ie9GE2WBSd=rPRFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-block: add support HMB
 with feature commands.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Oct 24, 2017 at 1:18 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sat, Oct 21, 2017 at 03:54:16PM +0900, Minwoo Im wrote:
>> Add support HMB(Host Memory Block) with feature commands(Get Feature, Set Feature).
>> nvme-4.14 tree supports HMB features.
>> This patch will make nvme controller to return 32MiB preferred size of HMB to host via identify command.
>> Set Feature, Get Feature implemented for HMB.
>>
>> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
>> ---
>>  hw/block/nvme.c | 35 +++++++++++++++++++++++++++++++++++
>>  hw/block/nvme.h | 21 ++++++++++++++++++++-
>>  2 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index 6071dc1..d351781 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -605,6 +605,23 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>>      }
>>  }
>>
>> +static uint32_t nvme_get_feature_hmb(NvmeCtrl *n, NvmeCmd *cmd)
>> +{
>> +    uint32_t result = n->hmb_flag.flag;
>> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
>> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
>> +    NvmeHmbAttr attr = {0, };
>> +
>> +    attr.hsize = cpu_to_le32(n->hmb_attr.hsize);
>> +    attr.hmdlal = cpu_to_le32(n->hmb_attr.hmdlal);
>> +    attr.hmdlau = cpu_to_le32(n->hmb_attr.hmdlau);
>> +    attr.hmdlec = cpu_to_le32(n->hmb_attr.hmdlec);
>> +
>> +    nvme_dma_read_prp(n, (uint8_t *)&attr, sizeof(attr), prp1, prp2);
>
> This read can fail if prp1/prp2 are invalid.  How should the error be
> reported?

either or both prp1 and prp2 failed, there's no error handling in this code.
agreed it needs to be implemented if this code will be sent as a patch.

>
>> +
>> +    return result;
>> +}
>> +
>>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>  {
>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>> @@ -617,6 +634,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>      case NVME_NUMBER_OF_QUEUES:
>>          result = cpu_to_le32((n->num_queues - 1) | ((n->num_queues - 1) << 16));
>>          break;
>> +    case NVME_HOST_MEMORY_BUFFER:
>> +        result = nvme_get_feature_hmb(n, cmd);
>> +        break;
>>      default:
>>          return NVME_INVALID_FIELD | NVME_DNR;
>>      }
>> @@ -625,6 +645,16 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>      return NVME_SUCCESS;
>>  }
>>
>> +static void nvme_set_feature_hmb(NvmeCtrl *n, NvmeCmd *cmd)
>> +{
>> +    n->hmb_flag.flag = le32_to_cpu(cmd->cdw11);
>> +
>> +    n->hmb_attr.hsize = le32_to_cpu(cmd->cdw12);
>> +    n->hmb_attr.hmdlal = le32_to_cpu(cmd->cdw13);
>> +    n->hmb_attr.hmdlau = le32_to_cpu(cmd->cdw14);
>> +    n->hmb_attr.hmdlec = le32_to_cpu(cmd->cdw15);
>> +}
>> +
>>  static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>  {
>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>> @@ -638,6 +668,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>          req->cqe.result =
>>              cpu_to_le32((n->num_queues - 1) | ((n->num_queues - 1) << 16));
>>          break;
>> +    case NVME_HOST_MEMORY_BUFFER:
>> +        nvme_set_feature_hmb(n, cmd);
>> +        break;
>>      default:
>>          return NVME_INVALID_FIELD | NVME_DNR;
>>      }
>> @@ -985,6 +1018,8 @@ static int nvme_init(PCIDevice *pci_dev)
>>      id->oacs = cpu_to_le16(0);
>>      id->frmw = 7 << 1;
>>      id->lpa = 1 << 0;
>> +    id->hmpre = 0x2000;
>
> Missing cpu_to_le32()?

agreed hmpre should be set with le32 instead of raw value.

>
>> +    id->hmmin = 0x0;
>>      id->sqes = (0x6 << 4) | 0x6;
>>      id->cqes = (0x4 << 4) | 0x4;
>>      id->nn = cpu_to_le32(n->num_namespaces);
>> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
>> index 6aab338..fab748b 100644
>> --- a/hw/block/nvme.h
>> +++ b/hw/block/nvme.h
>> @@ -552,7 +552,10 @@ typedef struct NvmeIdCtrl {
>>      uint8_t     lpa;
>>      uint8_t     elpe;
>>      uint8_t     npss;
>> -    uint8_t     rsvd511[248];
>> +    uint8_t     rsvd271[8];
>> +    uint32_t    hmpre;
>> +    uint32_t    hmmin;
>> +    uint8_t     rsvd511[232];
>>      uint8_t     sqes;
>>      uint8_t     cqes;
>>      uint16_t    rsvd515;
>> @@ -623,9 +626,22 @@ enum NvmeFeatureIds {
>>      NVME_INTERRUPT_VECTOR_CONF      = 0x9,
>>      NVME_WRITE_ATOMICITY            = 0xa,
>>      NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
>> +    NVME_HOST_MEMORY_BUFFER         = 0xd,
>>      NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
>>  };
>>
>> +typedef struct NvmeHmbFlag {
>> +    uint32_t    flag;
>> +} NvmeHmbFlag;
>> +
>> +typedef struct NvmeHmbAttr {
>> +    uint32_t    hsize;
>> +    uint32_t    hmdlal;
>> +    uint32_t    hmdlau;
>> +    uint32_t    hmdlec;
>> +    uint8_t     rsvd4095[4080];
>> +} NvmeHmbAttr;
>> +
>>  typedef struct NvmeRangeType {
>>      uint8_t     type;
>>      uint8_t     attributes;
>> @@ -776,6 +792,9 @@ typedef struct NvmeCtrl {
>>      uint32_t    cmbloc;
>>      uint8_t     *cmbuf;
>>
>> +    NvmeHmbFlag hmb_flag;
>> +    NvmeHmbAttr hmb_attr;
>> +
>>      char            *serial;
>>      NvmeNamespace   *namespaces;
>>      NvmeSQueue      **sq;
>> --
>> 2.7.4
>>
>>

I'll send it again with delicate verification and much deeper considerations.
Thank you for a review for this patch.
