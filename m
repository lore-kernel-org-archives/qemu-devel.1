Received: from eggs.gnu.org ([2001:4830:134:3::10]:49723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e4WfP-0007G2-4p
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 14:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e4WfN-0004F3-Qs
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 14:32:39 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:47176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e4WfN-0004DS-GG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 14:32:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id t69so5664209wmt.2
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 11:32:36 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <6ca0c9fa-0e28-cd41-70d6-aedfc23055d6@redhat.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<3400959d36218ad30e914439ab5d893ed9c87aae.1506730372.git.alistair.francis@xilinx.com>
	<6ca0c9fa-0e28-cd41-70d6-aedfc23055d6@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Oct 2017 11:32:04 -0700
Message-ID: <CAKmqyKPL+mEHS4WmnvpeFAfzxMw0rs7MZyLh=u50spmvnindJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 07/47] hw/bt: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Sun, Oct 1, 2017 at 7:06 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 30.09.2017 02:15, Alistair Francis wrote:
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and then
>> compiler issues where manually fixed.
> [...]
>> diff --git a/hw/bt/core.c b/hw/bt/core.c
>> index c1806b71a3..a6e9bf2a3e 100644
>> --- a/hw/bt/core.c
>> +++ b/hw/bt/core.c
>> @@ -18,6 +18,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "qemu-common.h"
>>  #include "sysemu/bt.h"
>>  #include "hw/bt.h"
>> @@ -31,24 +32,24 @@ static void bt_dummy_lmp_mode_change(struct bt_link_s *link)
>>  static void bt_dummy_lmp_connection_complete(struct bt_link_s *link)
>>  {
>>      if (link->slave->reject_reason)
>> -        fprintf(stderr, "%s: stray LMP_not_accepted received, fixme\n",
>> -                        __func__);
>> +        error_report("%s: stray LMP_not_accepted received, fixme",
>> +                     __func__);
>>      else
>> -        fprintf(stderr, "%s: stray LMP_accepted received, fixme\n",
>> -                        __func__);
>> +        error_report("%s: stray LMP_accepted received, fixme",
>> +                     __func__);
>
> I think these lines should now also easily fit into one line only.
>
>>      exit(-1);
>>  }
>>
>>  static void bt_dummy_lmp_disconnect_master(struct bt_link_s *link)
>>  {
>> -    fprintf(stderr, "%s: stray LMP_detach received, fixme\n", __func__);
>> +    fprintf(stderr, "%s: stray LMP_detach received, fixme", __func__);
>>      exit(-1);
>>  }
>>
>>  static void bt_dummy_lmp_acl_resp(struct bt_link_s *link,
>>                  const uint8_t *data, int start, int len)
>>  {
>> -    fprintf(stderr, "%s: stray ACL response PDU, fixme\n", __func__);
>> +    error_report("%s: stray ACL response PDU, fixme", __func__);
>>      exit(-1);
>>  }
>>
>> @@ -113,7 +114,7 @@ void bt_device_done(struct bt_device_s *dev)
>>      while (*p && *p != dev)
>>          p = &(*p)->next;
>>      if (*p != dev) {
>> -        fprintf(stderr, "%s: bad bt device \"%s\"\n", __func__,
>> +        error_report("%s: bad bt device \"%s\"", __func__,
>>                          dev->lmp_name ?: "(null)");
>
> Bad indentation of the second line.
>
>>          exit(-1);
>>      }
>> diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
>> index ac067b81f6..6a171a54b7 100644
>> --- a/hw/bt/hci-csr.c
>> +++ b/hw/bt/hci-csr.c
>> @@ -19,6 +19,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "qemu-common.h"
>>  #include "chardev/char-serial.h"
>>  #include "qemu/timer.h"
>> @@ -111,14 +112,14 @@ static uint8_t *csrhci_out_packet(struct csrhci_s *s, int len)
>>
>>      if (off < FIFO_LEN) {
>>          if (off + len > FIFO_LEN && (s->out_size = off + len) > FIFO_LEN * 2) {
>> -            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
>> +            error_report("%s: can't alloc %i bytes", __func__, len);
>>              exit(-1);
>>          }
>>          return s->outfifo + off;
>>      }
>>
>>      if (s->out_len > s->out_size) {
>> -        fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
>> +        error_report("%s: can't alloc %i bytes", __func__, len);
>>          exit(-1);
>>      }
>>
>> @@ -168,8 +169,8 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s, int ocf,
>>              s->bd_addr.b[5] = data[offset + 2];
>>
>>              s->hci->bdaddr_set(s->hci, s->bd_addr.b);
>> -            fprintf(stderr, "%s: bd_address loaded from firmware: "
>> -                            "%02x:%02x:%02x:%02x:%02x:%02x\n", __func__,
>> +            error_report("%s: bd_address loaded from firmware: "
>> +                            "%02x:%02x:%02x:%02x:%02x:%02x", __func__,
>>                              s->bd_addr.b[0], s->bd_addr.b[1], s->bd_addr.b[2],
>>                              s->bd_addr.b[3], s->bd_addr.b[4], s->bd_addr.b[5]);
>
> Bad indentation again.
>
>>          }
>> @@ -181,7 +182,7 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s, int ocf,
>>          break;
>>
>>      default:
>> -        fprintf(stderr, "%s: got a bad CMD packet\n", __func__);
>> +        error_report("%s: got a bad CMD packet", __func__);
>>          return;
>>      }
>>
>> @@ -226,7 +227,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
>>      case H4_NEG_PKT:
>>          if (s->in_hdr != sizeof(csrhci_neg_packet) ||
>>                          memcmp(pkt - 1, csrhci_neg_packet, s->in_hdr)) {
>> -            fprintf(stderr, "%s: got a bad NEG packet\n", __func__);
>> +            error_report("%s: got a bad NEG packet", __func__);
>>              return;
>>          }
>>          pkt += 2;
>> @@ -241,7 +242,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
>>
>>      case H4_ALIVE_PKT:
>>          if (s->in_hdr != 4 || pkt[1] != 0x55 || pkt[2] != 0x00) {
>> -            fprintf(stderr, "%s: got a bad ALIVE packet\n", __func__);
>> +            error_report("%s: got a bad ALIVE packet", __func__);
>>              return;
>>          }
>>
>> @@ -254,7 +255,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
>>      default:
>>      bad_pkt:
>>          /* TODO: error out */
>> -        fprintf(stderr, "%s: got a bad packet\n", __func__);
>> +        error_report("%s: got a bad packet", __func__);
>>          break;
>>      }
>>
>> diff --git a/hw/bt/hci.c b/hw/bt/hci.c
>> index df05f07887..ac9394daf0 100644
>> --- a/hw/bt/hci.c
>> +++ b/hw/bt/hci.c
>> @@ -19,6 +19,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "qapi/error.h"
>>  #include "qemu-common.h"
>>  #include "qemu/timer.h"
>> @@ -457,7 +458,7 @@ static inline uint8_t *bt_hci_event_start(struct bt_hci_s *hci,
>>      int mask_byte;
>>
>>      if (len > 255) {
>> -        fprintf(stderr, "%s: HCI event params too long (%ib)\n",
>> +        error_report("%s: HCI event params too long (%ib)",
>>                          __func__, len);
>
> Bad indentation again - or even better: Put it into one line only.
>
>>          exit(-1);
>>      }
>> @@ -589,7 +590,7 @@ static void bt_hci_inquiry_result(struct bt_hci_s *hci,
>>          bt_hci_inquiry_result_with_rssi(hci, slave);
>>          return;
>>      default:
>> -        fprintf(stderr, "%s: bad inquiry mode %02x\n", __func__,
>> +        error_report("%s: bad inquiry mode %02x", __func__,
>>                          hci->lm.inquiry_mode);
>
> Bad indentation.
>
>>          exit(-1);
>>      }
>> @@ -1971,7 +1972,7 @@ static void bt_submit_hci(struct HCIInfo *info,
>>          break;
>>
>>      short_hci:
>> -        fprintf(stderr, "%s: HCI packet too short (%iB)\n",
>> +        error_report("%s: HCI packet too short (%iB)",
>>                          __func__, length);
>
> One line, please.
>
>>          bt_hci_event_status(hci, HCI_INVALID_PARAMETERS);
>>          break;
>> @@ -1991,7 +1992,7 @@ static inline void bt_hci_lmp_acl_data(struct bt_hci_s *hci, uint16_t handle,
>>      /* TODO: avoid memcpy'ing */
>>
>>      if (len + HCI_ACL_HDR_SIZE > sizeof(hci->acl_buf)) {
>> -        fprintf(stderr, "%s: can't take ACL packets %i bytes long\n",
>> +        error_report("%s: can't take ACL packets %i bytes long",
>>                          __func__, len);
>
> Fix indentation or put it on one line.
>
>>          return;
>>      }
>> @@ -2029,7 +2030,7 @@ static void bt_submit_acl(struct HCIInfo *info,
>>      struct bt_link_s *link;
>>
>>      if (length < HCI_ACL_HDR_SIZE) {
>> -        fprintf(stderr, "%s: ACL packet too short (%iB)\n",
>> +        error_report("%s: ACL packet too short (%iB)",
>>                          __func__, length);
>
> One line.
>
>>          return;
>>      }
>> @@ -2041,15 +2042,15 @@ static void bt_submit_acl(struct HCIInfo *info,
>>      length -= HCI_ACL_HDR_SIZE;
>>
>>      if (bt_hci_handle_bad(hci, handle)) {
>> -        fprintf(stderr, "%s: invalid ACL handle %03x\n",
>> -                        __func__, handle);
>> +        error_report("%s: invalid ACL handle %03x",
>> +                     __func__, handle);
>
> One line.
>
>>          /* TODO: signal an error */
>>          return;
>>      }
>>      handle &= ~HCI_HANDLE_OFFSET;
>>
>>      if (datalen > length) {
>> -        fprintf(stderr, "%s: ACL packet too short (%iB < %iB)\n",
>> +        fprintf(stderr, "%s: ACL packet too short (%iB < %iB)",
>>                          __func__, length, datalen);
>
> script failure?
>
>>          return;
>>      }
>> @@ -2060,7 +2061,7 @@ static void bt_submit_acl(struct HCIInfo *info,
>>          if (!hci->asb_handle)
>>              hci->asb_handle = handle;
>>          else if (handle != hci->asb_handle) {
>> -            fprintf(stderr, "%s: Bad handle %03x in Active Slave Broadcast\n",
>> +            error_report("%s: Bad handle %03x in Active Slave Broadcast",
>>                              __func__, handle);
>
> Indentation.
>
> etc.
>
> Please have a look at all the hunks in this patch before you submit it
>again!

Thanks for going through these.

I did try to review the changes, but there are just so many it's
really difficult to catch them all.

Thanks,
Alistair

>
>  Thomas
