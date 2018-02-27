Received: from eggs.gnu.org ([2001:4830:134:3::10]:38318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqdVw-0003Rm-6u
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqdVs-0007CB-Uv
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:33:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eqdVs-0007Bu-R5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:33:40 -0500
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-14-git-send-email-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <957151ea-178c-f8a9-7875-1b26bf4a981b@redhat.com>
Date: Tue, 27 Feb 2018 12:33:29 +0100
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-14-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

On 27/02/2018 06:39, Emilio G. Cota wrote:
> Using a hash table or a binary tree to keep track of the jumps
> doesn't really pay off, not only due to the increased memory usage,
> but also because most TBs have only 0 or 1 jumps to them. The maximum
> number of jumps when booting debian-arm that I measured is 35, but
> as we can see in the histogram below a TB with that many incoming jumps
> is extremely rare; the average TB has 0.80 incoming jumps.
>=20
> n_jumps: 379208; avg jumps/tb: 0.801099
> dist: [0.0,1.0)|=E2=96=84=E2=96=88=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=
=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=E2=
=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=E2=96=81=E2=96=81  =E2=
=96=81=E2=96=81=E2=96=81     =E2=96=81|[34.0,35.0]

This makes sense, for example:

   while(...) {
   }

2 basic blocks, 0 and 1 incoming jumps (avg 0.5)

   if(...) {
   }

2 basic blocks, 0 and 1 incoming jumps (avg 0.5)

   if(...) {
   } else {
   }

3 basic blocks, 0, 1 and 1 incoming jumps (avg 0.66)

So 0.8 is actually a lot. :)  The long tail is probably for switch
statements.

Paolo
