Received: from eggs.gnu.org ([2001:4830:134:3::10]:60187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZD2L-0004Xn-6B
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZD2H-0000Ub-9n
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:51:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZD2H-0000Td-2l
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:51:05 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <001601d389f6$0816d2f0$184478d0$@ru> (Pavel Dovgalyuk's message
	of "Wed, 10 Jan 2018 12:33:11 +0300")
References: <20171220100205.16625.84632.stgit@pasha-VirtualBox>
	<003c01d38923$1c5157f0$54f407d0$@ru> <87efmz1ddp.fsf@secure.laptop>
	<004301d38940$56013bb0$0203b310$@ru> <87zi5nyyap.fsf@secure.laptop>
	<001601d389f6$0816d2f0$184478d0$@ru>
Reply-To: quintela@redhat.com
Date: Wed, 10 Jan 2018 10:50:58 +0100
Message-ID: <87d12iyrct.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, mst@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

"Pavel Dovgalyuk" <dovgaluk@ispras.ru> wrote:
>> From: Juan Quintela [mailto:quintela@redhat.com]
>> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> wrote:
>> >> From: Juan Quintela [mailto:quintela@redhat.com]
>> If you *don't* use a needed function then please just increase the
>> version.  You are just breaking compatibility anyways.  The whole point
>> of subsections is that they are optional.  If they are mandatory (this
>> case), then they bring no advantage at all.
>
> Thanks, I thought that the sections are skipped automatically when
> there is no code for loading
> them.
>
>> What dave is asked for your previous version is that you disable the
>> section for old machine types.  Look at how to use DEFINE_PROP_* for
>> this use case.
>
> How do you like this one?

Much better, thanks.

> +static bool hpet_offset_needed(void *opaque)
> +{
> +    HPETState *s = opaque;
> +
> +    return s->hpet_offset_saved;
> +}
> +

If this is only one optimization, this test is ok.  If it makes things
go worse, you can add something there like && hpet_enabled() or
whatever.  Remember that I don't understand HPET.


> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 263de97..8897302 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -13,6 +13,10 @@
>          .driver   = "virtio-tablet-device",\
>          .property = "wheel-axis",\
>          .value    = "false",\
> +    },{\
> +        .driver   = "hpet",\
> +        .property = "hpet-offset-saved",\
> +        .value    = "off",\
>      },
>  
>  #define HW_COMPAT_2_9 \

This should be on 2_11 not 2_10 O:-)

But for the vmstate bits:

Reviewed-by: Juan Quintela <quintela@redhat.com>
