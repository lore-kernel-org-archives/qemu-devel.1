Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEmqD-0000Y0-1W
	for qemu-devel@nongnu.org; Fri, 04 May 2018 22:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEmq8-0003AP-Uz
	for qemu-devel@nongnu.org; Fri, 04 May 2018 22:22:28 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:44419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEmq8-0003A6-Pk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 22:22:24 -0400
Received: by mail-qk0-x243.google.com with SMTP id z8so18122610qki.11
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 19:22:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180504155918.21287-1-f4bug@amsat.org>
	<20180504155918.21287-18-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d611dc36-e429-eb13-a2ec-573b0bb06413@amsat.org>
Date: Fri, 4 May 2018 23:22:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180504155918.21287-18-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/20] sdcard: Add SDFrameData struct and
 data frame checksum functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

On 05/04/2018 12:59 PM, Philippe Mathieu-Daudé wrote:
> The block transfers data frames are upto 512 bytes and use a 16-bit CRC.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/sd/sd.h     | 29 +++++++++++++++++++++++++++++
>  hw/sd/sdmmc-internal.c | 10 ++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index c76be51b32..6bf9daf559 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -102,6 +102,17 @@ typedef struct SDFrame136 {
>      uint8_t crc;
>  } SDFrame136;
>  
> +/**
> + * SDFrameData: 512 bytes block transfers
> + *
> + * @content: block data
> + * @crc:     16-bit CRC checksum
> + */
> +typedef struct SDFrameData {
> +    uint8_t content[512];
> +    uint16_t crc;
> +} SDFrameData;
> +
>  typedef struct SDFrame48 SDRequest;
>  
>  typedef struct SDState SDState;
> @@ -212,6 +223,14 @@ void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response);
>   */
>  void sd_update_frame136_checksum(SDFrame136 *frame);
>  
> +/**
> + * sd_update_framedata_checksum:
> + * @frame: the #SDFrameData to verify
> + *
> + * Update the 16-bit CRC checksum of a SD data frame (up to 512 bytes).
> + */
> +void sd_update_framedata_checksum(SDFrameData *frame);

Since the frame size is variable, this function needs a size_t argument.

> +
>  /**
>   * sd_verify_frame48_checksum:
>   * @frame: the #SDFrame48 to verify
> @@ -233,6 +252,16 @@ bool sd_verify_frame48_checksum(SDFrame48 *frame, bool is_response);
>   */
>  bool sd_verify_frame136_checksum(SDFrame136 *frame);
>  
> +/**
> + * sd_verify_framedata_checksum:
> + * @frame: the #SDFrameData to verify
> + *
> + * Verify the 16-bit CRC checksum of a SD data frame.
> + *
> + * Returns: A boolean indicating whether the frame 16-bit CRC is correct.
> + */
> +bool sd_verify_framedata_checksum(SDFrameData *frame);

Ditto.

> +
>  /* Legacy functions to be used only by non-qdevified callers */
>  SDState *sd_init(BlockBackend *bs, bool is_spi);
>  int sd_do_command(SDState *sd, SDRequest *req,
> diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
> index 68350a2304..0e82e69d99 100644
> --- a/hw/sd/sdmmc-internal.c
> +++ b/hw/sd/sdmmc-internal.c
> @@ -134,6 +134,11 @@ bool sd_verify_frame136_checksum(SDFrame136 *frame)
>      return sd_calc_frame136_crc7(frame) == frame->crc;
>  }
>  
> +bool sd_verify_framedata_checksum(SDFrameData *frame)
> +{
> +    return sd_crc16(frame->content, sizeof(frame->content)) == frame->crc;

I'll probably replace sizeof(frame->content) by a 'length' argument,
or add a 'length' member to SDFrameData.

> +}
> +
>  void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response)
>  {
>      frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg, is_response);
> @@ -144,6 +149,11 @@ void sd_update_frame136_checksum(SDFrame136 *frame)
>      frame->crc = (sd_crc7(frame->content, sizeof(frame->content)) << 1) | 1;
>  }
>  
> +void sd_update_framedata_checksum(SDFrameData *frame)
> +{
> +    frame->crc = sd_crc16(frame->content, sizeof(frame->content));
> +}
> +
>  void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
>                          bool is_response, bool gen_crc)
>  {
> 
