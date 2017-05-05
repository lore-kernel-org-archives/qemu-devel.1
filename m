Received: from eggs.gnu.org ([2001:4830:134:3::10]:37825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippevoinov@gmail.com>) id 1d6ZYP-0003Wo-3G
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippevoinov@gmail.com>) id 1d6ZYO-0007EM-3i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:29:37 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:36716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippevoinov@gmail.com>)
	id 1d6ZYN-0007EF-UH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:29:36 -0400
Received: by mail-io0-x229.google.com with SMTP id p80so750744iop.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 02:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20170505075918.4033-1-philippevoinov@gmail.com>
	<1493973586.371.65.camel@redhat.com>
In-Reply-To: <1493973586.371.65.camel@redhat.com>
From: Philippe Voinov <philippevoinov@gmail.com>
Date: Fri, 05 May 2017 09:29:24 +0000
Message-ID: <CA+fj4vkysW7iJ4WCLdK-Z9J6MX2pfEZKZyWwFoEbiaOsAre8Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ui: input-linux: Add absolute event support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

I doubt that any physical input device uses the full 32 bit range. The idea
behind this check is more that if someone implements a uinput device and
decides to use the maximum range, passing their values straight through to
ui/input.c would cause weird behavior of the cursor. Exiting with a warning
here is supposed to make this easier to debug - in these cases, the person
implementing the input device can simply use a smaller range.

Aside from that, trying to change ui/input.c is probably a bad idea. The
code
there expects absolute input values to start at 0. To use the full 32 bits
of
an int would require absolute axes to have a different starting position.
This
would require large changes to ui/input.c and possibly also other code using
it. Also there's not much to gain, since we would probably still convert
values
into a range much smaller than 32 bits, as we do now.

Regards
-
Philippe

On Fri, May 5, 2017 at 10:39 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > This patch allows, for example, uinput to be used to create virtual
> > absolute input devices. This lets you build external systems which share
> > physical input devices between guests.
>
> Ah, interesting.
>
> > +static bool input_linux_abs_range_is_valid(int min, int max)
> > +{
> > +  int64_t difference = ((int64_t) max) - ((int64_t) min);
> > +  return difference > 0 && difference <= INT_MAX;
> > +}
>
> Does this happen in practice?
> If so we might consider improving ui/input.c instead.
>
> cheers,
>   Gerd
>
>
