Received: from eggs.gnu.org ([2001:4830:134:3::10]:56030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dNvvm-0002U2-G9
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dNvvi-0007ds-Dl
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:49:30 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:35718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1dNvvi-0007cw-5B
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:49:26 -0400
Message-Id: <594B8493020000780016595C@prv-mh.provo.novell.com>
Date: Thu, 22 Jun 2017 00:49:23 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706201421210.12819@sstabellini-ThinkPad-X260>
	<594A2A1C0200007800164F2A@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706211108530.12819@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1706211108530.12819@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH] xen/disk: don't leak stack data via
 response ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Julien Grall <julien.grall@arm.com>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

>>> On 21.06.17 at 20:46, <sstabellini@kernel.org> wrote:
> On Wed, 21 Jun 2017, Jan Beulich wrote:
>> >>> On 20.06.17 at 23:48, <sstabellini@kernel.org> wrote:
>> > On Tue, 20 Jun 2017, Jan Beulich wrote:
>> >> @@ -36,13 +33,7 @@ struct blkif_x86_32_request_discard {
>> >>      blkif_sector_t sector_number;    /* start sector idx on disk =
(r/w=20
> only)  */
>> >>      uint64_t       nr_sectors;       /* # of contiguous sectors to =
discard=20
>   */
>> >>  };
>> >> -struct blkif_x86_32_response {
>> >> -    uint64_t        id;              /* copied from request */
>> >> -    uint8_t         operation;       /* copied from request */
>> >> -    int16_t         status;          /* BLKIF_RSP_???       */
>> >> -};
>> >>  typedef struct blkif_x86_32_request blkif_x86_32_request_t;
>> >> -typedef struct blkif_x86_32_response blkif_x86_32_response_t;
>> >>  #pragma pack(pop)
>> >> =20
>> >>  /* x86_64 protocol version */
>> >> @@ -62,20 +53,14 @@ struct blkif_x86_64_request_discard {
>> >>      blkif_sector_t sector_number;    /* start sector idx on disk =
(r/w=20
> only)  */
>> >>      uint64_t       nr_sectors;       /* # of contiguous sectors to =
discard=20
>   */
>> >>  };
>> >> -struct blkif_x86_64_response {
>> >> -    uint64_t       __attribute__((__aligned__(8))) id;
>> >> -    uint8_t         operation;       /* copied from request */
>> >> -    int16_t         status;          /* BLKIF_RSP_???       */
>> >> -};
>> >>
>> >>  typedef struct blkif_x86_64_request blkif_x86_64_request_t;
>> >> -typedef struct blkif_x86_64_response blkif_x86_64_response_t;
>> >> =20
>> >>  DEFINE_RING_TYPES(blkif_common, struct blkif_common_request,
>> >> -                  struct blkif_common_response);
>> >> +                  struct blkif_response);
>> >>  DEFINE_RING_TYPES(blkif_x86_32, struct blkif_x86_32_request,
>> >> -                  struct blkif_x86_32_response);
>> >> +                  struct blkif_response QEMU_PACKED);
>> >=20
>> > In my test, the previous sizes and alignments of the response structs
>> > were (on both x86_32 and x86_64):
>> >=20
>> > sizeof(blkif_x86_32_response)=3D12   sizeof(blkif_x86_64_response)=3D1=
6
>> > align(blkif_x86_32_response)=3D4     align(blkif_x86_64_response)=3D8
>> >=20
>> > While with these changes are now, when compiled on x86_64:
>> > sizeof(blkif_x86_32_response)=3D11   sizeof(blkif_x86_64_response)=3D1=
6
>> > align(blkif_x86_32_response)=3D1     align(blkif_x86_64_response)=3D8
>> >=20
>> > when compiled on x86_32:
>> > sizeof(blkif_x86_32_response)=3D11   sizeof(blkif_x86_64_response)=3D1=
2
>> > align(blkif_x86_32_response)=3D1     align(blkif_x86_64_response)=3D4
>> >=20
>> > Did I do my tests wrong?
>> >=20
>> > QEMU_PACKED is not the same as #pragma pack(push, 4). In fact, it is =
the
>> > same as #pragma pack(push, 1), causing the struct to be densely =
packed,
>> > leaving no padding whatsever.
>> >=20
>> > In addition, without __attribute__((__aligned__(8))),
>> > blkif_x86_64_response won't be 8 bytes aligned when built on x86_32.
>> >=20
>> > Am I missing something?
>>=20
>> Well, you're mixing attribute application upon structure
>> declaration with attribute application upon structure use. It's
>> the latter here, and hence the attribute doesn't affect
>> structure layout at all. All it does is avoid the _containing_
>> 32-bit union to become 8-byte aligned (and tail padding to be
>> inserted).
>=20
> Thanks for the explanation. I admit it's the first time I see the
> aligned attribute being used at structure usage only. I think it's the
> first time QEMU_PACKED is used this way in QEMU too.
>=20
> Anyway, even taking that into account, things are still not completely
> right: the alignment of struct blkif_x86_32_response QEMU_PACKED is 4
> bytes as you wrote, but the size of struct blkif_x86_32_response is
> still 16 bytes instead of 12 bytes in my test. I suspect it worked for
> you because the other member of the union (blkif_x86_32_request) is
> larger than that. However, I think is not a good idea to rely on this
> implementation detail. The implementation of DEFINE_RING_TYPES should be
> opaque from our point of view. We shouldn't have to know that there is a
> union there.

I don't follow - why should we not rely on this? It is a fundamental
aspect of the shared ring model that requests and responses share
space.

> Moreover, the other problem is still unaddressed: the size and alignment
> of blkif_x86_64_response when built on x86_32 are 12 and 4 instead of 16
> and 8 bytes. Is that working also because it's relying on the other
> member of the union to enforce the right alignment and bigger size?

Yes. For these as well as your comments further up - sizeof() and
alignof() are completely uninteresting as long as we don't
instantiate objects of those types _and then use them for
communication_. The patch specifically removes instantiation,
switching to a purely pointer based approach. And that is ...

> I think it's a bad idea to rely on that, especially given that this
> obscure but important detail is not even mentioned in the commit =
message.

... what the commit message explicitly says (except that of course
the reason for doing so is not the sizeof/alignof aspect, but the
security issue we mean to fix). Everything else is just mechanical
detail of how the goal is being achieved. I don't really mind
extending the commit message (admitting that I'm known to not
write the best ones), but I also don't really see the need.

In the end I'm surprised the qemu side is proving so much more
difficult to get accepted compared to the Linux one.

Jan
