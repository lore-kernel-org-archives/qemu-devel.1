Received: from eggs.gnu.org ([2001:4830:134:3::10]:53773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzu4o-0001Bw-3x
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 21:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzu4i-0000NK-5R
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 21:36:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzu4h-0000Ic-2X
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 21:36:11 -0400
Date: Tue, 11 Sep 2018 21:36:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180912013602.GA24650@flamenco>
References: <20180910185859.27917-1-cota@braap.org>
	<20180910185859.27917-13-cota@braap.org>
	<8fc81928-961d-7c5b-b34e-38f55d4257af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc81928-961d-7c5b-b34e-38f55d4257af@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 12/12] qht-bench: add -p flag to
 precompute hash values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, Sep 11, 2018 at 17:46:41 -0700, Richard Henderson wrote:
> On 09/10/2018 11:58 AM, Emilio G. Cota wrote:
> > @@ -289,7 +297,9 @@ static void htable_init(void)
> >      /* avoid allocating memory later by allocating all the keys now */
> >      keys = g_malloc(sizeof(*keys) * n);
> >      for (i = 0; i < n; i++) {
> > -        keys[i] = populate_offset + i;
> > +        long val = populate_offset + i;
> > +
> > +        keys[i] = precompute_hash ? h(val) : hval(val);
> 
> hfunc?

Here is where precomputation happens, so if precompute_hash is set,
then we insert the hashed value. Otherwise we insert the non-hashed
value (with hval()). In all other instances we use hfunc, since
hfunc is set to the "other" hash function wrt the above--see
this later hunk:

@@ -451,6 +461,10 @@ static void parse_args(int argc, char *argv[])
         case 'o':
             populate_offset = atol(optarg);
             break;
+        case 'p':
+            precompute_hash = true;
+            hfunc = hval;
+            break;

Thanks,

		Emilio
