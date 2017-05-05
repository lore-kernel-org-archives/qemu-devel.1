Received: from eggs.gnu.org ([2001:4830:134:3::10]:35083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6kCd-0007qD-J7
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6kCa-0005o0-GY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6kCa-0005m1-B0
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:51:48 -0400
Date: Fri, 5 May 2017 17:51:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505205145.GO3482@thinpad.lan.raisama.net>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-3-ehabkost@redhat.com>
	<9f623263-e78c-fbb3-5ac4-5629d68c4bbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f623263-e78c-fbb3-5ac4-5629d68c4bbc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: Add enum_table[] parameter to
 start_alternate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, May 05, 2017 at 03:45:01PM -0500, Eric Blake wrote:
> On 05/05/2017 03:11 PM, Eduardo Habkost wrote:
> > The new parameter will be used by the string input visitor to detect
> > alternate types that can't be parsed unambiguously.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * (new patch added to series)
> > ---
> 
> > +++ b/include/qapi/visitor.h
> > @@ -411,13 +411,21 @@ void visit_end_list(Visitor *v, void **list);
> >   * @supported_qtypes is a bit mask indicating which QTypes are supported
> >   * by the alternate.
> >   *
> > + * @enum_table contains the enum value lookup table, in case
> > + * strings in the input are going to be parsed as enums. Visitors
> > + * aren't required to validate string input according to
> > + * enum_table, as visit_type_enum() will be called automatically
> > + * if (*obj)->type is QTYPE_QSTRING.
> 
> Presumably, enum_table will be NULL if the alternate type does not
> include an enum?  [reads ahead] yes. Should be documented.
> 
> I'm less convinced we need this patch, if we can instead guarantee at
> QAPI-generation time that alternates are not possible if they would
> cause an ambiguity.

I am not 100% sure either. I just have the feeling that we are
likely to break the rules and allow ambiguous enums in
exceptional cases in the future, and then this code will be
useful.

That doesn't mean we need to maintain it in the source tree. We
can leave it on the git history, or just on the qemu-devel
archives.

-- 
Eduardo
