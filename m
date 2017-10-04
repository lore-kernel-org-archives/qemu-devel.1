Received: from eggs.gnu.org ([2001:4830:134:3::10]:38942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzefL-0001lk-HD
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzefI-0002JE-D8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzefI-0002Fu-7q
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:04:24 -0400
Date: Wed, 4 Oct 2017 10:04:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004100415.0f0ded10.cohuck@redhat.com>
In-Reply-To: <87k20eq9em.fsf@dusky.pond.sub.org>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-19-david@redhat.com>
	<87k20eq9em.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 18/22] s390x: implement
 query-hotpluggable-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 02 Oct 2017 09:46:41 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> David Hildenbrand <david@redhat.com> writes:
> 
> > CPU hotplug is only possible on a per core basis on s390x. So let's
> > add possible_cpus and properly wire everything up.
> >
> > Signed-off-by: David Hildenbrand <david@redhat.com>  
> [...]
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index f3af2cb851..79e9f85404 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -3121,6 +3121,22 @@
> >  #      }
> >  #    ]}
> >  #
> > +# For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu qemu
> > +# (Since: 2.11):
> > +#
> > +# -> { "execute": "query-hotpluggable-cpus" }
> > +# <- {"return": [
> > +#      {
> > +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
> > +#         "props": { "core-id": 1 }
> > +#      },
> > +#      {
> > +#         "qom-path": "/machine/unattached/device[0]",
> > +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
> > +#         "props": { "core-id": 0 }
> > +#      }
> > +#    ]}
> > +#
> >  ##
> >  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }  
> 
> Please stick in '# Example:' like we do in query-hotpluggable-cpus's doc
> comment.  I expect the generated documentation to be illegible[*]
> without it.

Should '# Example:' go before each of the examples (instead of the
beginning of the example block), then?

> 
> 
> [*] If you want to perform a quick eye-over, try running "make
> tests/qapi-schema/doc-good.test.txt" and examine the result.

Hmm... I might be missing something in my setup:

[cohuck@gondolin build]$ make tests/qapi-schema/doc-good.test.txt
  GEN     tests/qapi-schema/doc-good.test.txt
tests/qapi-schema/doc-good.test.texi:79: @subsection seen before @end deftp
tests/qapi-schema/doc-good.test.texi:90: unmatched `@end deftp'
make: *** [Makefile:695: tests/qapi-schema/doc-good.test.txt] Error 1
