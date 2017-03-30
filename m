Received: from eggs.gnu.org ([2001:4830:134:3::10]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctcJm-00069g-1V
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctcJi-000832-TX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ctcJi-00082g-N3
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:54 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<1490856931-21732-3-git-send-email-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3907cf8-21bc-97eb-e8a9-2c387192f0da@redhat.com>
Date: Thu, 30 Mar 2017 17:48:50 +0200
MIME-Version: 1.0
In-Reply-To: <1490856931-21732-3-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RfC PATCH 2/4] memory: add support getting and
 using a dirty bitmap copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>



On 30/03/2017 08:55, Gerd Hoffmann wrote:
> +        bitmap_copy(copy->dirty + dest,
> +                    blocks->blocks[idx] + (offset >> BITS_PER_LEVEL),
> +                    num);
> +        bitmap_zero(blocks->blocks[idx] + (offset >> BITS_PER_LEVEL),
> +                    num);
> +

This needs to access the bitmap atomically, so you'll need a new function

  bool bitmap_copy_and_clear_atomic(unsigned long *dest,
				    unsigned long *src, long nr)

Paolo
