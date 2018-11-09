Received: from eggs.gnu.org ([2001:4830:134:3::10]:59729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gL89W-0004ej-D3
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gL89T-0006TV-4f
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:52:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gL89S-0006SD-P2
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:52:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	wA9EhW2M153966
	for <qemu-devel@nongnu.org>; Fri, 9 Nov 2018 14:52:48 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp2120.oracle.com with ESMTP id 2nh4ar7c18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 14:52:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA9Eqgau031862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 9 Nov 2018 14:52:42 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA9EqgE4020893
	for <qemu-devel@nongnu.org>; Fri, 9 Nov 2018 14:52:42 GMT
References: <20181109141447.13101-1-kraxel@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <2edf0d6a-eb22-6df4-272c-d9b207923a88@oracle.com>
Date: Fri, 9 Nov 2018 14:52:39 +0000
MIME-Version: 1.0
In-Reply-To: <20181109141447.13101-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/bt: drop bluetooth keyboard emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 09/11/2018 14:14, Gerd Hoffmann wrote:
> Broken (segfaultson first keypress) and appearently unused.
> 

s/segfaultson/segfaults on/
s/appearently/apparently/

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

one question at the end, otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

> ---
>   include/hw/bt.h     |   3 -
>   hw/bt/hid.c         | 554 ----------------------------------------------------
>   vl.c                |  34 +---
>   hw/bt/Makefile.objs |   3 +-
>   qemu-options.hx     |   9 -
>   5 files changed, 2 insertions(+), 601 deletions(-)
>   delete mode 100644 hw/bt/hid.c
> 
> diff --git a/include/hw/bt.h b/include/hw/bt.h
> index b5e11d4d43..73fb1911f6 100644
> --- a/include/hw/bt.h
> +++ b/include/hw/bt.h
> @@ -173,9 +173,6 @@ enum bt_l2cap_psm_predef {
>   /* bt-sdp.c */
>   void bt_l2cap_sdp_init(struct bt_l2cap_device_s *dev);
>   
> -/* bt-hid.c */
> -struct bt_device_s *bt_keyboard_init(struct bt_scatternet_s *net);
> -
>   /* Link Management Protocol layer defines */
>   
>   #define LLID_ACLU_CONT		0x1
> diff --git a/hw/bt/hid.c b/hw/bt/hid.c
> deleted file mode 100644
> index 056291f9b5..0000000000
> --- a/hw/bt/hid.c
> +++ /dev/null
> @@ -1,554 +0,0 @@
> -/*
> - * QEMU Bluetooth HID Profile wrapper for USB HID.
> - *
> - * Copyright (C) 2007-2008 OpenMoko, Inc.
> - * Written by Andrzej Zaborowski <andrew@openedhand.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 or
> - * (at your option) version 3 of the License.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu-common.h"
> -#include "qemu/timer.h"
> -#include "ui/console.h"
> -#include "hw/input/hid.h"
> -#include "hw/bt.h"
> -
> -enum hid_transaction_req {
> -    BT_HANDSHAKE			= 0x0,
> -    BT_HID_CONTROL			= 0x1,
> -    BT_GET_REPORT			= 0x4,
> -    BT_SET_REPORT			= 0x5,
> -    BT_GET_PROTOCOL			= 0x6,
> -    BT_SET_PROTOCOL			= 0x7,
> -    BT_GET_IDLE				= 0x8,
> -    BT_SET_IDLE				= 0x9,
> -    BT_DATA				= 0xa,
> -    BT_DATC				= 0xb,
> -};
> -
> -enum hid_transaction_handshake {
> -    BT_HS_SUCCESSFUL			= 0x0,
> -    BT_HS_NOT_READY			= 0x1,
> -    BT_HS_ERR_INVALID_REPORT_ID		= 0x2,
> -    BT_HS_ERR_UNSUPPORTED_REQUEST	= 0x3,
> -    BT_HS_ERR_INVALID_PARAMETER		= 0x4,
> -    BT_HS_ERR_UNKNOWN			= 0xe,
> -    BT_HS_ERR_FATAL			= 0xf,
> -};
> -
> -enum hid_transaction_control {
> -    BT_HC_NOP				= 0x0,
> -    BT_HC_HARD_RESET			= 0x1,
> -    BT_HC_SOFT_RESET			= 0x2,
> -    BT_HC_SUSPEND			= 0x3,
> -    BT_HC_EXIT_SUSPEND			= 0x4,
> -    BT_HC_VIRTUAL_CABLE_UNPLUG		= 0x5,
> -};
> -
> -enum hid_protocol {
> -    BT_HID_PROTO_BOOT			= 0,
> -    BT_HID_PROTO_REPORT			= 1,
> -};
> -
> -enum hid_boot_reportid {
> -    BT_HID_BOOT_INVALID			= 0,
> -    BT_HID_BOOT_KEYBOARD,
> -    BT_HID_BOOT_MOUSE,
> -};
> -
> -enum hid_data_pkt {
> -    BT_DATA_OTHER			= 0,
> -    BT_DATA_INPUT,
> -    BT_DATA_OUTPUT,
> -    BT_DATA_FEATURE,
> -};
> -
> -#define BT_HID_MTU			48
> -
> -/* HID interface requests */
> -#define GET_REPORT			0xa101
> -#define GET_IDLE			0xa102
> -#define GET_PROTOCOL			0xa103
> -#define SET_REPORT			0x2109
> -#define SET_IDLE			0x210a
> -#define SET_PROTOCOL			0x210b
> -
> -struct bt_hid_device_s {
> -    struct bt_l2cap_device_s btdev;
> -    struct bt_l2cap_conn_params_s *control;
> -    struct bt_l2cap_conn_params_s *interrupt;
> -    HIDState hid;
> -
> -    int proto;
> -    int connected;
> -    int data_type;
> -    int intr_state;
> -    struct {
> -        int len;
> -        uint8_t buffer[1024];
> -    } dataother, datain, dataout, feature, intrdataout;
> -    enum {
> -        bt_state_ready,
> -        bt_state_transaction,
> -        bt_state_suspend,
> -    } state;
> -};
> -
> -static void bt_hid_reset(struct bt_hid_device_s *s)
> -{
> -    struct bt_scatternet_s *net = s->btdev.device.net;
> -
> -    /* Go as far as... */
> -    bt_l2cap_device_done(&s->btdev);
> -    bt_l2cap_device_init(&s->btdev, net);
> -
> -    hid_reset(&s->hid);
> -    s->proto = BT_HID_PROTO_REPORT;
> -    s->state = bt_state_ready;
> -    s->dataother.len = 0;
> -    s->datain.len = 0;
> -    s->dataout.len = 0;
> -    s->feature.len = 0;
> -    s->intrdataout.len = 0;
> -    s->intr_state = 0;
> -}
> -
> -static int bt_hid_out(struct bt_hid_device_s *s)
> -{
> -    if (s->data_type == BT_DATA_OUTPUT) {
> -        /* nothing */
> -        ;
> -    }
> -
> -    if (s->data_type == BT_DATA_FEATURE) {
> -        /* XXX:
> -         * does this send a USB_REQ_CLEAR_FEATURE/USB_REQ_SET_FEATURE
> -         * or a SET_REPORT? */
> -        ;
> -    }
> -
> -    return -1;
> -}
> -
> -static int bt_hid_in(struct bt_hid_device_s *s)
> -{
> -    s->datain.len = hid_keyboard_poll(&s->hid, s->datain.buffer,
> -                                      sizeof(s->datain.buffer));
> -    return s->datain.len;
> -}
> -
> -static void bt_hid_send_handshake(struct bt_hid_device_s *s, int result)
> -{
> -    *s->control->sdu_out(s->control, 1) =
> -            (BT_HANDSHAKE << 4) | result;
> -    s->control->sdu_submit(s->control);
> -}
> -
> -static void bt_hid_send_control(struct bt_hid_device_s *s, int operation)
> -{
> -    *s->control->sdu_out(s->control, 1) =
> -            (BT_HID_CONTROL << 4) | operation;
> -    s->control->sdu_submit(s->control);
> -}
> -
> -static void bt_hid_disconnect(struct bt_hid_device_s *s)
> -{
> -    /* Disconnect s->control and s->interrupt */
> -}
> -
> -static void bt_hid_send_data(struct bt_l2cap_conn_params_s *ch, int type,
> -                const uint8_t *data, int len)
> -{
> -    uint8_t *pkt, hdr = (BT_DATA << 4) | type;
> -    int plen;
> -
> -    do {
> -        plen = MIN(len, ch->remote_mtu - 1);
> -        pkt = ch->sdu_out(ch, plen + 1);
> -
> -        pkt[0] = hdr;
> -        if (plen)
> -            memcpy(pkt + 1, data, plen);
> -        ch->sdu_submit(ch);
> -
> -        len -= plen;
> -        data += plen;
> -        hdr = (BT_DATC << 4) | type;
> -    } while (plen == ch->remote_mtu - 1);
> -}
> -
> -static void bt_hid_control_transaction(struct bt_hid_device_s *s,
> -                const uint8_t *data, int len)
> -{
> -    uint8_t type, parameter;
> -    int rlen, ret = -1;
> -    if (len < 1)
> -        return;
> -
> -    type = data[0] >> 4;
> -    parameter = data[0] & 0xf;
> -
> -    switch (type) {
> -    case BT_HANDSHAKE:
> -    case BT_DATA:
> -        switch (parameter) {
> -        default:
> -            /* These are not expected to be sent this direction.  */
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -        }
> -        break;
> -
> -    case BT_HID_CONTROL:
> -        if (len != 1 || (parameter != BT_HC_VIRTUAL_CABLE_UNPLUG &&
> -                                s->state == bt_state_transaction)) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -        switch (parameter) {
> -        case BT_HC_NOP:
> -            break;
> -        case BT_HC_HARD_RESET:
> -        case BT_HC_SOFT_RESET:
> -            bt_hid_reset(s);
> -            break;
> -        case BT_HC_SUSPEND:
> -            if (s->state == bt_state_ready)
> -                s->state = bt_state_suspend;
> -            else
> -                ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        case BT_HC_EXIT_SUSPEND:
> -            if (s->state == bt_state_suspend)
> -                s->state = bt_state_ready;
> -            else
> -                ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        case BT_HC_VIRTUAL_CABLE_UNPLUG:
> -            bt_hid_disconnect(s);
> -            break;
> -        default:
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -        }
> -        break;
> -
> -    case BT_GET_REPORT:
> -        /* No ReportIDs declared.  */
> -        if (((parameter & 8) && len != 3) ||
> -                        (!(parameter & 8) && len != 1) ||
> -                        s->state != bt_state_ready) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -        if (parameter & 8)
> -            rlen = data[2] | (data[3] << 8);
> -        else
> -            rlen = INT_MAX;
> -        switch (parameter & 3) {
> -        case BT_DATA_OTHER:
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        case BT_DATA_INPUT:
> -            /* Here we can as well poll s->usbdev */
> -            bt_hid_send_data(s->control, BT_DATA_INPUT,
> -                            s->datain.buffer, MIN(rlen, s->datain.len));
> -            break;
> -        case BT_DATA_OUTPUT:
> -            bt_hid_send_data(s->control, BT_DATA_OUTPUT,
> -                            s->dataout.buffer, MIN(rlen, s->dataout.len));
> -            break;
> -        case BT_DATA_FEATURE:
> -            bt_hid_send_data(s->control, BT_DATA_FEATURE,
> -                            s->feature.buffer, MIN(rlen, s->feature.len));
> -            break;
> -        }
> -        break;
> -
> -    case BT_SET_REPORT:
> -        if (len < 2 || len > BT_HID_MTU || s->state != bt_state_ready ||
> -                        (parameter & 3) == BT_DATA_OTHER ||
> -                        (parameter & 3) == BT_DATA_INPUT) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -        s->data_type = parameter & 3;
> -        if (s->data_type == BT_DATA_OUTPUT) {
> -            s->dataout.len = len - 1;
> -            memcpy(s->dataout.buffer, data + 1, s->dataout.len);
> -        } else {
> -            s->feature.len = len - 1;
> -            memcpy(s->feature.buffer, data + 1, s->feature.len);
> -        }
> -        if (len == BT_HID_MTU)
> -            s->state = bt_state_transaction;
> -        else
> -            bt_hid_out(s);
> -        break;
> -
> -    case BT_GET_PROTOCOL:
> -        if (len != 1 || s->state == bt_state_transaction) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -        *s->control->sdu_out(s->control, 1) = s->proto;
> -        s->control->sdu_submit(s->control);
> -        break;
> -
> -    case BT_SET_PROTOCOL:
> -        if (len != 1 || s->state == bt_state_transaction ||
> -                        (parameter != BT_HID_PROTO_BOOT &&
> -                         parameter != BT_HID_PROTO_REPORT)) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -        s->proto = parameter;
> -        s->hid.protocol = parameter;
> -        ret = BT_HS_SUCCESSFUL;
> -        break;
> -
> -    case BT_GET_IDLE:
> -        if (len != 1 || s->state == bt_state_transaction) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -        *s->control->sdu_out(s->control, 1) = s->hid.idle;
> -        s->control->sdu_submit(s->control);
> -        break;
> -
> -    case BT_SET_IDLE:
> -        if (len != 2 || s->state == bt_state_transaction) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -
> -        s->hid.idle = data[1];
> -        /* XXX: Does this generate a handshake? */
> -        break;
> -
> -    case BT_DATC:
> -        if (len > BT_HID_MTU || s->state != bt_state_transaction) {
> -            ret = BT_HS_ERR_INVALID_PARAMETER;
> -            break;
> -        }
> -        if (s->data_type == BT_DATA_OUTPUT) {
> -            memcpy(s->dataout.buffer + s->dataout.len, data + 1, len - 1);
> -            s->dataout.len += len - 1;
> -        } else {
> -            memcpy(s->feature.buffer + s->feature.len, data + 1, len - 1);
> -            s->feature.len += len - 1;
> -        }
> -        if (len < BT_HID_MTU) {
> -            bt_hid_out(s);
> -            s->state = bt_state_ready;
> -        }
> -        break;
> -
> -    default:
> -        ret = BT_HS_ERR_UNSUPPORTED_REQUEST;
> -    }
> -
> -    if (ret != -1)
> -        bt_hid_send_handshake(s, ret);
> -}
> -
> -static void bt_hid_control_sdu(void *opaque, const uint8_t *data, int len)
> -{
> -    struct bt_hid_device_s *hid = opaque;
> -
> -    bt_hid_control_transaction(hid, data, len);
> -}
> -
> -static void bt_hid_datain(HIDState *hs)
> -{
> -    struct bt_hid_device_s *hid =
> -        container_of(hs, struct bt_hid_device_s, hid);
> -
> -    /* If suspended, wake-up and send a wake-up event first.  We might
> -     * want to also inspect the input report and ignore event like
> -     * mouse movements until a button event occurs.  */
> -    if (hid->state == bt_state_suspend) {
> -        hid->state = bt_state_ready;
> -    }
> -
> -    if (bt_hid_in(hid) > 0)
> -        /* TODO: when in boot-mode precede any Input reports with the ReportID
> -         * byte, here and in GetReport/SetReport on the Control channel.  */
> -        bt_hid_send_data(hid->interrupt, BT_DATA_INPUT,
> -                        hid->datain.buffer, hid->datain.len);
> -}
> -
> -static void bt_hid_interrupt_sdu(void *opaque, const uint8_t *data, int len)
> -{
> -    struct bt_hid_device_s *hid = opaque;
> -
> -    if (len > BT_HID_MTU || len < 1)
> -        goto bad;
> -    if ((data[0] & 3) != BT_DATA_OUTPUT)
> -        goto bad;
> -    if ((data[0] >> 4) == BT_DATA) {
> -        if (hid->intr_state)
> -            goto bad;
> -
> -        hid->data_type = BT_DATA_OUTPUT;
> -        hid->intrdataout.len = 0;
> -    } else if ((data[0] >> 4) == BT_DATC) {
> -        if (!hid->intr_state)
> -            goto bad;
> -    } else
> -        goto bad;
> -
> -    memcpy(hid->intrdataout.buffer + hid->intrdataout.len, data + 1, len - 1);
> -    hid->intrdataout.len += len - 1;
> -    hid->intr_state = (len == BT_HID_MTU);
> -    if (!hid->intr_state) {
> -        memcpy(hid->dataout.buffer, hid->intrdataout.buffer,
> -                        hid->dataout.len = hid->intrdataout.len);
> -        bt_hid_out(hid);
> -    }
> -
> -    return;
> -bad:
> -    error_report("%s: bad transaction on Interrupt channel.",
> -                    __func__);
> -}
> -
> -/* "Virtual cable" plug/unplug event.  */
> -static void bt_hid_connected_update(struct bt_hid_device_s *hid)
> -{
> -    int prev = hid->connected;
> -
> -    hid->connected = hid->control && hid->interrupt;
> -
> -    /* Stop page-/inquiry-scanning when a host is connected.  */
> -    hid->btdev.device.page_scan = !hid->connected;
> -    hid->btdev.device.inquiry_scan = !hid->connected;
> -
> -    if (hid->connected && !prev) {
> -        hid_reset(&hid->hid);
> -        hid->proto = BT_HID_PROTO_REPORT;
> -    }
> -
> -    /* Should set HIDVirtualCable in SDP (possibly need to check that SDP
> -     * isn't destroyed yet, in case we're being called from handle_destroy) */
> -}
> -
> -static void bt_hid_close_control(void *opaque)
> -{
> -    struct bt_hid_device_s *hid = opaque;
> -
> -    hid->control = NULL;
> -    bt_hid_connected_update(hid);
> -}
> -
> -static void bt_hid_close_interrupt(void *opaque)
> -{
> -    struct bt_hid_device_s *hid = opaque;
> -
> -    hid->interrupt = NULL;
> -    bt_hid_connected_update(hid);
> -}
> -
> -static int bt_hid_new_control_ch(struct bt_l2cap_device_s *dev,
> -                struct bt_l2cap_conn_params_s *params)
> -{
> -    struct bt_hid_device_s *hid = (struct bt_hid_device_s *) dev;
> -
> -    if (hid->control)
> -        return 1;
> -
> -    hid->control = params;
> -    hid->control->opaque = hid;
> -    hid->control->close = bt_hid_close_control;
> -    hid->control->sdu_in = bt_hid_control_sdu;
> -
> -    bt_hid_connected_update(hid);
> -
> -    return 0;
> -}
> -
> -static int bt_hid_new_interrupt_ch(struct bt_l2cap_device_s *dev,
> -                struct bt_l2cap_conn_params_s *params)
> -{
> -    struct bt_hid_device_s *hid = (struct bt_hid_device_s *) dev;
> -
> -    if (hid->interrupt)
> -        return 1;
> -
> -    hid->interrupt = params;
> -    hid->interrupt->opaque = hid;
> -    hid->interrupt->close = bt_hid_close_interrupt;
> -    hid->interrupt->sdu_in = bt_hid_interrupt_sdu;
> -
> -    bt_hid_connected_update(hid);
> -
> -    return 0;
> -}
> -
> -static void bt_hid_destroy(struct bt_device_s *dev)
> -{
> -    struct bt_hid_device_s *hid = (struct bt_hid_device_s *) dev;
> -
> -    if (hid->connected)
> -        bt_hid_send_control(hid, BT_HC_VIRTUAL_CABLE_UNPLUG);
> -    bt_l2cap_device_done(&hid->btdev);
> -
> -    hid_free(&hid->hid);
> -
> -    g_free(hid);
> -}
> -
> -enum peripheral_minor_class {
> -    class_other		= 0 << 4,
> -    class_keyboard	= 1 << 4,
> -    class_pointing	= 2 << 4,
> -    class_combo		= 3 << 4,
> -};
> -
> -static struct bt_device_s *bt_hid_init(struct bt_scatternet_s *net,
> -                                       enum peripheral_minor_class minor)
> -{
> -    struct bt_hid_device_s *s = g_malloc0(sizeof(*s));
> -    uint32_t class =
> -            /* Format type */
> -            (0 << 0) |
> -            /* Device class */
> -            (minor << 2) |
> -            (5 << 8) |  /* "Peripheral" */
> -            /* Service classes */
> -            (1 << 13) | /* Limited discoverable mode */
> -            (1 << 19);  /* Capturing device (?) */
> -
> -    bt_l2cap_device_init(&s->btdev, net);
> -    bt_l2cap_sdp_init(&s->btdev);
> -    bt_l2cap_psm_register(&s->btdev, BT_PSM_HID_CTRL,
> -                    BT_HID_MTU, bt_hid_new_control_ch);
> -    bt_l2cap_psm_register(&s->btdev, BT_PSM_HID_INTR,
> -                    BT_HID_MTU, bt_hid_new_interrupt_ch);
> -
> -    hid_init(&s->hid, HID_KEYBOARD, bt_hid_datain);
> -    s->btdev.device.lmp_name = "BT Keyboard";
> -
> -    s->btdev.device.handle_destroy = bt_hid_destroy;
> -
> -    s->btdev.device.class[0] = (class >>  0) & 0xff;
> -    s->btdev.device.class[1] = (class >>  8) & 0xff;
> -    s->btdev.device.class[2] = (class >> 16) & 0xff;
> -
> -    return &s->btdev.device;
> -}
> -
> -struct bt_device_s *bt_keyboard_init(struct bt_scatternet_s *net)
> -{
> -    return bt_hid_init(net, class_keyboard);
> -}
> diff --git a/vl.c b/vl.c
> index 55bab005b6..2a12fc7f3e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -988,37 +988,6 @@ static void bt_vhci_add(int vlan_id)
>       bt_vhci_init(bt_new_hci(vlan));
>   }
>   
> -static struct bt_device_s *bt_device_add(const char *opt)
> -{
> -    struct bt_scatternet_s *vlan;
> -    int vlan_id = 0;
> -    char *endp = strstr(opt, ",vlan=");
> -    int len = (endp ? endp - opt : strlen(opt)) + 1;
> -    char devname[10];
> -
> -    pstrcpy(devname, MIN(sizeof(devname), len), opt);
> -
> -    if (endp) {
> -        vlan_id = strtol(endp + 6, &endp, 0);
> -        if (*endp) {
> -            error_report("unrecognised bluetooth vlan Id");
> -            return 0;
> -        }
> -    }
> -
> -    vlan = qemu_find_bt_vlan(vlan_id);
> -
> -    if (!vlan->slave)
> -        warn_report("adding a slave device to an empty scatternet %i",
> -                    vlan_id);
> -
> -    if (!strcmp(devname, "keyboard"))
> -        return bt_keyboard_init(vlan);
> -
> -    error_report("unsupported bluetooth device '%s'", devname);
> -    return 0;
> -}
> -
>   static int bt_parse(const char *opt)
>   {
>       const char *endp, *p;
> @@ -1051,8 +1020,7 @@ static int bt_parse(const char *opt)
>               bt_vhci_add(vlan);
>               return 0;
>           }
> -    } else if (strstart(opt, "device:", &endp))
> -        return !bt_device_add(endp);
> +    }
>   
>       error_report("bad bluetooth parameter '%s'", opt);
>       return 1;
> diff --git a/hw/bt/Makefile.objs b/hw/bt/Makefile.objs
> index 867a7d2e8a..a33983b522 100644
> --- a/hw/bt/Makefile.objs
> +++ b/hw/bt/Makefile.objs
> @@ -1,3 +1,2 @@
> -common-obj-y += core.o l2cap.o sdp.o hci.o hid.o
> +common-obj-y += core.o l2cap.o sdp.o hci.o
>   common-obj-y += hci-csr.o
> -
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 38c7a978c1..48885cdca8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx

In this file, should these two lines also be deleted?

2761     "-bt device:dev[,vlan=n]\n" \
2762     "                emulate a bluetooth device 'dev' in scatternet 
'n'\n",


> @@ -2804,15 +2804,6 @@ be used as following:
>   qemu-system-i386 [...OPTIONS...] -bt hci,vlan=5 -bt vhci,vlan=5
>   @end example
>   
> -@item -bt device:@var{dev}[,vlan=@var{n}]
> -Emulate a bluetooth device @var{dev} and place it in network @var{n}
> -(default @code{0}).  QEMU can only emulate one type of bluetooth devices
> -currently:
> -
> -@table @option
> -@item keyboard
> -Virtual wireless keyboard implementing the HIDP bluetooth profile.
> -@end table
>   ETEXI
>   
>   STEXI
> 
