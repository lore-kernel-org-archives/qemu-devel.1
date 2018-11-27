Received: from eggs.gnu.org ([2001:4830:134:3::10]:49827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRdmB-0002un-Ar
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRdm5-0001Zb-IT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRdm3-0001Tl-Ln
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:37 -0500
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a17b878-9a1c-7cdc-0250-187e82e2faf3@redhat.com>
Date: Tue, 27 Nov 2018 14:51:15 +0100
MIME-Version: 1.0
In-Reply-To: <BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe de Dinechin <dinechin@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

On 27/11/18 13:49, Christophe de Dinechin wrote:
> So this is not really
> helping. Also, the ThreadLocal structure itself is not necessarily alig=
ned
> within struct Threads. Therefore, it=E2=80=99s possible that =E2=80=9Cr=
equests=E2=80=9D for example
> could be on the same cache line as request_fill_bitmap if planets align
> the wrong way.

I think this is a bit exaggerated.  Linux and QEMU's own qht work just
fine with compile-time directives.

> In order to mitigate these effects, I would group the data that the use=
r
> writes and the data that the thread writes, i.e. reorder declarations,
> put request_fill_bitmap and request_valid_ev together, and try
> to put them in the same cache line so that only one cache line is inval=
idated
> from within mark_request_valid instead of two.
>=20
> Then you end up with a single alignment directive instead of 4, to
> separate requests from completions.

Yeah, I agree with this.

> That being said, I=E2=80=99m not sure why you use a bitmap here. What i=
s the
> expected benefit relative to atomic lists (which would also make it rea=
lly
> lock-free)?
>=20

I don't think lock-free lists are easier.  Bitmaps smaller than 64
elements are both faster and easier to manage.

Paolo
