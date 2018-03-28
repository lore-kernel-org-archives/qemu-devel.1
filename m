Received: from eggs.gnu.org ([2001:4830:134:3::10]:35805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f12ZV-0006Nt-N0
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f12ZR-0003b4-GW
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:20:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f12ZR-0003an-CJ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:20:21 -0400
Date: Wed, 28 Mar 2018 12:20:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180328042003.GB29554@xz-mi>
References: <20180328030351.GU17789@xz-mi> <201803281208196040484@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201803281208196040484@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support todetectcompression
 and decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: guangrong.xiao@gmail.com, kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On Wed, Mar 28, 2018 at 12:08:19PM +0800, jiang.biao2@zte.com.cn wrote:
> >=20
> > On Tue, Mar 27, 2018 at 10:35:29PM +0800, Xiao Guangrong wrote:
> >
> >> > > No, we can't make the assumption that "error _must_ be caused by=
 page update".
> >> > > No document/ABI about compress/decompress promised it. :)
> >
> > Indeed, I found no good documents about below errors that jiang.biao
> > pointed out.
> Hi, Peter
> The description about the errors comes from here,
> http://www.zlib.net/manual.html
> And about the error codes returned by inflate(), they are described as=EF=
=BC=8C
> ** inflate() returns=20
> Z_OK if some progress has been made (more input processed or more outpu=
t produced),
> Z_STREAM_END if the end of the compressed data has been reached and all=
 uncompressed output has been produced,=20
> Z_NEED_DICT if a preset dictionary is needed at this point,=20
> Z_DATA_ERROR if the input data was corrupted (input stream not conformi=
ng to the zlib format or incorrect check value, in which case strm->msg p=
oints to a string with a more specific error),=20
> Z_STREAM_ERROR if the stream structure was inconsistent (for example ne=
xt_in or next_out was Z_NULL, or the state was inadvertently written over=
 by the application),=20
> Z_MEM_ERROR if there was not enough memory,=20
> Z_BUF_ERROR if no progress was possible or if there was not enough room=
 in the output buffer when Z_FINISH is used. ...=20
> **

Ah yes.  My bad to be so uncareful. :)

> According to the above description, the error caused by page update loo=
ks=20
> more like tend to return Z_DATA_ERROR, but I do not have env to verify =
that. :)
> As I understand it, the real compress/decompress error cases other than=
 that=20
> caused by page update should be rare, maybe the error code is enough to
> distinguish those if we can verify the the error codes returned by page=
 update
> and other silent failures by test. If so, we can cut the cost of memcpy=
. =20
> If not, I agree with Guangrong's idea too. I never read the zlib code a=
nd all my
> information comes from the manual, so if anything inaccurate, pls ignor=
e my
> option. :)

So I suppose all of us know that alternative now, we just need a solid
way to confirm the uncertainty.  I'll leave this to Guangrong.

Thanks,

--=20
Peter Xu
