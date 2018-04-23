Received: from eggs.gnu.org ([2001:4830:134:3::10]:38792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fAXp0-0004S9-22
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fAXow-0000kw-1Q
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:31:42 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:51896
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1fAXov-0000kF-QD
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:31:37 -0400
References: <20180419131051.11249-1-kraxel@redhat.com>
	<20180419131051.11249-5-kraxel@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <833e23a9-4899-2a95-c4b1-027d437e2ef7@adacore.com>
Date: Mon, 23 Apr 2018 11:31:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180419131051.11249-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] audio/hda: detect output buffer
 overruns and underruns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: martin@schrodt.org



On 04/19/2018 03:10 PM, Gerd Hoffmann wrote:
> If some event caused some larger playback hickup the fine-grained timer
> adjust isn't able to recover.  Use a buffer overruns and underruns as
> indicator for that.  Reset timer adjust logic in case we detected one.

It seems that this patch causes big lockup of my Win10 KVM guest
when it tries to output a sound.
The three previous patches improved considerably the audio
output though!

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/audio/hda-codec.c  | 22 ++++++++++++++++++++++
>   hw/audio/trace-events |  2 ++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index f6fb1d0fa0..623021b7c7 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -261,6 +261,13 @@ static void hda_audio_input_cb(void *opaque, int avail)
>   
>       int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), avail);
>   
> +    if (to_transfer == 0) {
> +        /* reset timer adjust */
> +        st->buft_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        trace_hda_audio_underrun(st->node->name);
> +        return;
> +    }
> +
>       hda_timer_sync_adjust(st, -((wpos - rpos) + to_transfer - (B_SIZE >> 1)));
>   
>       while (to_transfer) {
> @@ -325,6 +332,21 @@ static void hda_audio_output_cb(void *opaque, int avail)
>   
>       int64_t to_transfer = audio_MIN(wpos - rpos, avail);
>   
> +    if (to_transfer == 0) {
> +        /* reset timer adjust */
> +        st->buft_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        trace_hda_audio_underrun(st->node->name);
> +        return;
> +    }

The lock happen here:

hda_audio_output_cb is called a lot and keeps running in
underrun. While the 1kHz callback is called regularly and
always "already have the data". So I wonder if the adjust here is
not confusing the 1kHz callback which refuse to get new data.

Regards,
Fred
