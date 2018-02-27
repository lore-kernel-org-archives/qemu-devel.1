Received: from eggs.gnu.org ([2001:4830:134:3::10]:53953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqgHz-0007rY-FI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqgHu-00057g-F7
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:31:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eqgHu-00057Y-AI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:31:26 -0500
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-14-git-send-email-cota@braap.org>
	<957151ea-178c-f8a9-7875-1b26bf4a981b@redhat.com>
	<CABoDooM4xfHQ5ZrgMAfPoc2-_hJiv7WLpg92G40+_b-8+oabOg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5cb753f-12e7-b7d4-b41e-ff83bb3bece4@redhat.com>
Date: Tue, 27 Feb 2018 15:31:16 +0100
MIME-Version: 1.0
In-Reply-To: <CABoDooM4xfHQ5ZrgMAfPoc2-_hJiv7WLpg92G40+_b-8+oabOg@mail.gmail.com>
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
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 27/02/2018 12:43, Laurent Desnogues wrote:
> On Tue, Feb 27, 2018 at 12:33 PM, Paolo Bonzini <pbonzini@redhat.com> w=
rote:
>> On 27/02/2018 06:39, Emilio G. Cota wrote:
>>> Using a hash table or a binary tree to keep track of the jumps
>>> doesn't really pay off, not only due to the increased memory usage,
>>> but also because most TBs have only 0 or 1 jumps to them. The maximum
>>> number of jumps when booting debian-arm that I measured is 35, but
>>> as we can see in the histogram below a TB with that many incoming jum=
ps
>>> is extremely rare; the average TB has 0.80 incoming jumps.
>>>
>>> n_jumps: 379208; avg jumps/tb: 0.801099
>>> dist: [0.0,1.0)|=E2=96=84=E2=96=88=E2=96=81=E2=96=81=E2=96=81=E2=96=81=
=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=
=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=E2=96=81=E2=96=81=
  =E2=96=81=E2=96=81=E2=96=81     =E2=96=81|[34.0,35.0]
>>
>> This makes sense, for example:
>>
>>    while(...) {
>>    }
>>
>> 2 basic blocks, 0 and 1 incoming jumps (avg 0.5)
>>
>>    if(...) {
>>    }
>>
>> 2 basic blocks, 0 and 1 incoming jumps (avg 0.5)
>>
>>    if(...) {
>>    } else {
>>    }
>>
>> 3 basic blocks, 0, 1 and 1 incoming jumps (avg 0.66)
>>
>> So 0.8 is actually a lot. :)  The long tail is probably for switch
>> statements.
>=20
> And calls too :-)

Jumps are only chained within the same page, so probably only the
smaller buckets can be for calls.

Paolo
