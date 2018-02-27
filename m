Received: from eggs.gnu.org ([2001:4830:134:3::10]:41022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1eqdfu-0001GI-5D
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1eqdft-0003I7-Bl
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:44:02 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:44887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1eqdft-0003HU-72
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:44:01 -0500
Received: by mail-oi0-x22d.google.com with SMTP id b8so12607392oib.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 03:44:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <957151ea-178c-f8a9-7875-1b26bf4a981b@redhat.com>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-14-git-send-email-cota@braap.org>
	<957151ea-178c-f8a9-7875-1b26bf4a981b@redhat.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 27 Feb 2018 12:43:59 +0100
Message-ID: <CABoDooM4xfHQ5ZrgMAfPoc2-_hJiv7WLpg92G40+_b-8+oabOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/16] translate-all: protect TB jumps with
 a per-destination-TB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Tue, Feb 27, 2018 at 12:33 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> On 27/02/2018 06:39, Emilio G. Cota wrote:
>> Using a hash table or a binary tree to keep track of the jumps
>> doesn't really pay off, not only due to the increased memory usage,
>> but also because most TBs have only 0 or 1 jumps to them. The maximum
>> number of jumps when booting debian-arm that I measured is 35, but
>> as we can see in the histogram below a TB with that many incoming jumps
>> is extremely rare; the average TB has 0.80 incoming jumps.
>>
>> n_jumps: 379208; avg jumps/tb: 0.801099
>> dist: [0.0,1.0)|=E2=96=84=E2=96=88=E2=96=81=E2=96=81=E2=96=81=E2=96=81=
=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=
=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=E2=96=81=E2=96=81  =
=E2=96=81=E2=96=81=E2=96=81     =E2=96=81|[34.0,35.0]
>
> This makes sense, for example:
>
>    while(...) {
>    }
>
> 2 basic blocks, 0 and 1 incoming jumps (avg 0.5)
>
>    if(...) {
>    }
>
> 2 basic blocks, 0 and 1 incoming jumps (avg 0.5)
>
>    if(...) {
>    } else {
>    }
>
> 3 basic blocks, 0, 1 and 1 incoming jumps (avg 0.66)
>
> So 0.8 is actually a lot. :)  The long tail is probably for switch
> statements.

And calls too :-)


Laurent

> Paolo
>
