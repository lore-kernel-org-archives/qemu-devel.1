Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzJg-0007AM-Hm
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzJc-0005LA-In
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:51:04 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gMzJa-0005J1-PX
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:51:00 -0500
Date: Wed, 14 Nov 2018 12:50:53 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114175053.GC960@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-7-cota@braap.org> <87zhubd8lq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhubd8lq.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 06/48] tcg: use QHT for helper_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Nov 14, 2018 at 14:41:53 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > -static GHashTable *helper_table;
> > +static struct qht helper_table;
> > +static bool helper_table_inited;
> 
> Having a flag for initialisation seems a little excessive considering
> we've moved that initialisation into tcg_context_init() which has to be
> called before we do anything TCG related.

(snip)
> > +    helper_table_inited = true;
> 
> so I think we can drop this and...

(snip)
> > +static inline const char *tcg_helper_find(TCGContext *s, uintptr_t val)
> >  {
> >      const char *ret = NULL;
> > -    if (helper_table) {
> > -        TCGHelperInfo *info = g_hash_table_lookup(helper_table, (gpointer)val);
> > +    if (helper_table_inited) {
> 
> change this to a assert(helper_table.cmp) if you really want to.

I like this suggestion. The only caller of tcg_helper_find
is tcg_dump_ops, which is unlikely to be called on an
uninitialized TCGContext.

I have added this to v2, without the assert.

(snip)
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		E.
