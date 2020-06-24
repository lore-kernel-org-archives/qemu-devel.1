Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4054FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D1D2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fj4HOxmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D1D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5bL-00026U-F1
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo5ak-0001eP-Ny
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:37:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo5ai-0006k1-8e
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593005846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72zGkjcA1A4Lul97cOpEoah909DlGG2MmrKlS4mzcfM=;
 b=Fj4HOxmrEAl5JVljc3CRcCQEaZTVo97uHAsACmUNLD0exncxJ2nQK827yIMXV51DJggUif
 wXc8Cu3PPRbD0BRteFLK7G3DM9cV6Wkw5OZmwKHgg1M2p5369kLfx5skWsQgBL3IMtRE5J
 ZbEo4Ksi+SiUuMRCyuehaaiYKf2ITps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-tnEUb_vBMkecDKvLqDeG_Q-1; Wed, 24 Jun 2020 09:37:19 -0400
X-MC-Unique: tnEUb_vBMkecDKvLqDeG_Q-1
Received: by mail-wr1-f69.google.com with SMTP id d6so2952937wrn.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=72zGkjcA1A4Lul97cOpEoah909DlGG2MmrKlS4mzcfM=;
 b=fX8/aFAJtTvUvJhm5dhDpBUV+gA2pjO0ZmcffYdGLwraBbAuTEFZjk5sz/Pmrfk8OQ
 QOvGGNTzgEH2CDYYyjsnx72GocLaZXU/FsRrn6uu8cdxn25Jy/ViFO1/5BW4abujvRct
 lmajbee30lKb4HuF1lhjzK9sdU2JkMLE1v8auAnb+nvsoOP+8yvtOJ7LEsakT55wvPi6
 3Xh8hK2Og+yxvR0eG6TNlRCV4APVQXPJnm96iJ2j/47RJ2vSZxwqs8HxDD+fQmzJ1tRc
 JWdYmBu0BeYiv/wQToE3QiQMpOWQF778YJX8zHmD9HEm+tcdXGi2r5Va+LIrTzPPxvLM
 gCpA==
X-Gm-Message-State: AOAM530tVPIWPPgpC21P8KRnDq7houfodtWfZfQ6tiExfmz4iCjmi95V
 KS1jfOIKxQL6xEc91+MriKgi4Rmw+8aaeuDInKYDJwJQX4qvScrcxHcxYd3Ly798D6Fciwq/0C2
 r/HEKGftmaJWNqck=
X-Received: by 2002:adf:e60e:: with SMTP id p14mr6841455wrm.31.1593005838463; 
 Wed, 24 Jun 2020 06:37:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/A43EPAAE2n7XHxzYLdtMK5GkFVLYX7Gy5AgHsxtHGwGf5c/WtKsr4CwF8CLKT7TdSyfJPw==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr6841427wrm.31.1593005838213; 
 Wed, 24 Jun 2020 06:37:18 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id a2sm12719329wrn.68.2020.06.24.06.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 06:37:17 -0700 (PDT)
Date: Wed, 24 Jun 2020 09:37:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v2 5/6] virtio-serial-bus: add terminal resize messages
Message-ID: <20200624093703-mutt-send-email-mst@kernel.org>
References: <20200624112640.82673-1-noh4hss@gmail.com>
 <20200624112640.82673-6-noh4hss@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200624112640.82673-6-noh4hss@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, amit@kernel.org,
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 01:26:39PM +0200, Szymon Lukasz wrote:
> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. The virtio spec contains two methods to
> achieve that:
> 
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
> 
> For multiport devices, we use the control virtqueue to send a packet
> containing the terminal size. Note that the Linux kernel expects
> the fields indicating the number of rows and columns in a packet to be
> in a different order than the one specified in the current version of
> the virtio spec. We follow the Linux implementation, so hopefully there
> is no implementation of this functionality conforming to the spec.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>

Looks right to me:


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-serial-bus.c       | 42 +++++++++++++++++++++++++++++--
>  hw/core/machine.c                 |  1 +
>  include/hw/virtio/virtio-serial.h |  5 ++++
>  4 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index d20eafd56f..be40df47ea 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -10,6 +10,7 @@ serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
>  
>  # virtio-serial-bus.c
>  virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
> +virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
>  virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
>  virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
>  virtio_serial_handle_control_message_port(unsigned int port) "port %u"
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 262089c0c9..6d9e94a64e 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -261,6 +261,42 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
>      return send_control_msg(vser, &cpkt, sizeof(cpkt));
>  }
>  
> +/*
> + * This struct should be added to the Linux kernel uapi headers
> + * and later imported to standard-headers/linux/virtio_console.h
> + */
> +struct virtio_console_resize {
> +    __virtio16 rows;
> +    __virtio16 cols;
> +};
> +
> +void virtio_serial_send_console_resize(VirtIOSerialPort *port,
> +                                       uint16_t cols, uint16_t rows)
> +{
> +    VirtIOSerial *vser = port->vser;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
> +        struct {
> +            struct virtio_console_control control;
> +            struct virtio_console_resize resize;
> +        } buffer;
> +
> +        virtio_stl_p(vdev, &buffer.control.id, port->id);
> +        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
> +        virtio_stw_p(vdev, &buffer.resize.cols, cols);
> +        virtio_stw_p(vdev, &buffer.resize.rows, rows);
> +
> +        trace_virtio_serial_send_console_resize(port->id, cols, rows);
> +        send_control_msg(vser, &buffer, sizeof(buffer));
> +
> +    } else if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
> +        vser->port0_cols = cols;
> +        vser->port0_rows = rows;
> +        virtio_notify_config(vdev);
> +    }
> +}
> +
>  /* Functions for use inside qemu to open and read from/write to ports */
>  int virtio_serial_open(VirtIOSerialPort *port)
>  {
> @@ -572,8 +608,8 @@ static void get_config(VirtIODevice *vdev, uint8_t *config_data)
>      struct virtio_console_config *config =
>          (struct virtio_console_config *)config_data;
>  
> -    config->cols = 0;
> -    config->rows = 0;
> +    config->cols = virtio_tswap16(vdev, vser->port0_cols);
> +    config->rows = virtio_tswap16(vdev, vser->port0_rows);
>      config->max_nr_ports = virtio_tswap32(vdev,
>                                            vser->serial.max_virtserial_ports);
>  }
> @@ -1168,6 +1204,8 @@ static Property virtio_serial_properties[] = {
>                                                    31),
>      DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
>                        VIRTIO_CONSOLE_F_EMERG_WRITE, true),
> +    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
> +                      VIRTIO_CONSOLE_F_SIZE, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1d80ab0e1d..c370c220f0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,6 +30,7 @@
>  
>  GlobalProperty hw_compat_5_0[] = {
>      { "virtio-balloon-device", "page-poison", "false" },
> +    { "virtio-serial-device", "console-size", "off" },
>  };
>  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
>  
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
> index ed3e916b68..1d6436c0b1 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -188,6 +188,8 @@ struct VirtIOSerial {
>      virtio_serial_conf serial;
>  
>      uint64_t host_features;
> +
> +    uint16_t port0_cols, port0_rows;
>  };
>  
>  /* Interface to the virtio-serial bus */
> @@ -222,6 +224,9 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
>   */
>  void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
>  
> +void virtio_serial_send_console_resize(VirtIOSerialPort *port,
> +                                       uint16_t cols, uint16_t rows);
> +
>  #define TYPE_VIRTIO_SERIAL "virtio-serial-device"
>  #define VIRTIO_SERIAL(obj) \
>          OBJECT_CHECK(VirtIOSerial, (obj), TYPE_VIRTIO_SERIAL)
> -- 
> 2.27.0


