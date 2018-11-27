Received: from eggs.gnu.org ([2001:4830:134:3::10]:53587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRgqU-0000wk-0k
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRgqQ-0005Mf-1t
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:08:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRgqP-0005J7-Es
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 12:08:17 -0500
Date: Tue, 27 Nov 2018 12:08:11 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127170811.GA12617@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-42-cota@braap.org>
	<87h8g24t57.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8g24t57.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 41/48] configure: add --enable-plugins
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

On Tue, Nov 27, 2018 at 12:11:32 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > For now only add it for ELF platforms, since we rely on the linker's
> > --dynamic-list flag to pass a list of symbols to be exported to the
> > executable. An alternative would be to use -rdynamic, but that would
> > expose all of QEMU's objects to plugins.
> >
> > I have no experience with non-ELF systems but I suspect adding support
> > for those should be pretty easy.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> As far as the configure logic is concerned:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> I'm not quite following what is so special about the dynamic-list
> symbols compared to the rest of the symbols in the binary. when I do
> readelf -s they are all specified as GLOBAL DEFAULT.
> 
> Perhaps this will become clearer to me once I get to the implementation
> of the plugins later in the series?

You should look at `readelf --dyn-syms's output. There you'll see
that the only defined function symbols are qemu_plugin_* ones (plus
_init and _fini).

The goal is to prevent plugins from accessing symbols outside of
the plugin API. For instance, if from plugin 'foo' I try to call
qht_init (after having added the necessary declarations in foo.c),
at dlopen time I get:
  plugin_load: libfoo.so: undefined symbol: qht_init

The alternative is to export all symbols; we can do this by
passing --export-dynamic to the linker instead of an explicit
--dynamic-list. We can then access *any* global symbol in the
QEMU executable. The previous example now works past dlopen, i.e.
I can call qht_init from my plugin:
  ERROR:/data/src/qemu/util/qht.c:401:qht_init: assertion failed: (cmp)

Thanks,

		Emilio
