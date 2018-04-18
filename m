Received: from eggs.gnu.org ([2001:4830:134:3::10]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8jIe-0002vo-Up
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8jIa-0008Vz-A8
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:22:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8jIa-0008Vk-4J
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:22:44 -0400
Date: Wed, 18 Apr 2018 06:22:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180418092231.GK29865@localhost.localdomain>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-18-ehabkost@redhat.com>
	<87vacqf3da.fsf@dusky.pond.sub.org>
	<20180417144256.GW29865@localhost.localdomain>
	<87lgdl2e87.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgdl2e87.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC 17/18] validator.py script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 18, 2018 at 08:58:00AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Tue, Apr 17, 2018 at 02:01:53PM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> [...]
> >> > +    command-line: '$QEMU -nodefaults -machine none'
> >> > +    monitor-commands:
> >> > +    - qmp:
> >> > +      - execute: qom-list-types
> >> > +        arguments:
> >> > +          implements: 'device'
> >> > +          abstract: true
> >> > +    - hmp: 'device_add help'
> [...]
> >> > +monitor-commands
> >> > +~~~~~~~~~~~~~~~~
> >> > +
> >> > +Mapping or list-of-mappings containing monitor commands to run.
> 
> http://yaml.org/spec/1.2/spec.html talks about mappings and sequences.
> Recommend to say "sequence" rather than "list".

Noted.

> 
> I can't see how sequences come into play.  Your example's
> monitor-command is a mapping, not a sequence of mappings.  Am I
> confused?

The example is supposed to be a sequence of mappings.

> 
> >> >                                                                   The key on each
> >> > +item can be ``hmp`` or ``qmp``.  The value on each entry can be a string,
> >> > +mapping, or list.
> >> > +
> >> > +Default: None.
> [...]
> >> Can I do
> >> 
> >>     monitor-commands:
> >>     - qmp:
> >>       - execute: eins
> >>     - hmp: zwei
> >>     - qmp:
> >>       - execute: drei
> >> 
> >> to execute eins, zwei, drei in this order?
> >
> > Yes, it can.  See the test specification examples.
> 
> I asked because the YAML spec I quoted above says mappings are unordered
> and must be unique.  My example violates "unique", and your "yes, it
> can" violates "unordered".
> 
> [...]

The above is a sequence of one-key mappings.


This is a (not very useful) mapping:

>>> yaml.load("""
... qmp:
... - execute: eins
... hmp: zwei
... """)
{'qmp': [{'execute': 'eins'}], 'hmp': 'zwei'}


This is a sequence of one-key mappings:

>>> yaml.load("""
... - qmp:
...   - execute: eins
... - hmp: zwei
... - qmp:
...   - execute: drei
... """)
[{'qmp': [{'execute': 'eins'}]}, {'hmp': 'zwei'}, {'qmp': [{'execute': 'drei'}]}]
>>>

-- 
Eduardo
