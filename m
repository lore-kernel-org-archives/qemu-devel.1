Received: from eggs.gnu.org ([2001:4830:134:3::10]:56252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgF4U-0004Wr-JN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgF4T-0005Ku-GA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:21:54 -0500
Date: Tue, 21 Feb 2017 15:21:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170221182144.GG2778@thinpad.lan.raisama.net>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9JWzUEmGa2Wxd5xPE4dVknOKBkt=wMda7CAgxzrgOc+w@mail.gmail.com>
	<20170220195500.332a4844@nial.brq.redhat.com>
	<CAFEAcA-VAY8LM+8jE4B-L=0QdcY5FLvwmwGVbUhcXjnC9-AW+w@mail.gmail.com>
	<20170221134416.5803b3e5@nial.brq.redhat.com>
	<CAFEAcA-MggU5T1fO8GonkSpLF0SNe0jtygEHtEBkpWC8hyShSw@mail.gmail.com>
	<87poibr6kv.fsf@dusky.pond.sub.org>
	<CAFEAcA-75VPiOzPauZO4ukYVYWffB1cu1-tsQs6Hs8m8Vf41OQ@mail.gmail.com>
	<87fuj74k9q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fuj74k9q.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Tue, Feb 21, 2017 at 04:48:49PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 21 February 2017 at 13:56, Markus Armbruster <armbru@redhat.com> wrote:
> >> -global is a qdev thing.
> >
> > ...which reminds me to ask: is there any hope for unifying
> > our properties so we don't have both "qdev properties" and
> > "qom properties" or are we doomed to two distinct sets of
> > APIs forever?
> 
> Good question!  Paolo, Andreas, any ideas?

qdev properties are supposed to be just wrappers to easily add
QOM properties.

...in theory.

The current obstacles I see are:
1) the qdev static property macros (DEFINE_PROP_*) are very
   simple to use, and QOM property registration requires lots of
   boilerplate code;
2) The set of data types supported by the qdev macros doesn't
   seem to be a subset of the data types supported by QOM
   helpers.
3) qdev properties have the extra check for dev->realized on the
   setter functions.

If we make QOM properties as powerful and easy to use as the qdev
property system, replacing qdev properties with equivalent QOM
counterparts would be straightforward. The exact path we should
follow to do that is not clear to me, but cleanups going in that
direction would be welcome.

Some things I have considered, which may or may not be good
ideas:
* Getting rid of PropertyInfo structs that can't be represented
  by QAPI types (e.g. qdev_prop_ptr).
* Generating PropertyInfo structs for primitive types using QAPI.
* Providing DEFINE_PROP_* macros for QOM, and make the qdev ones
  just wrappers around the QOM macros.

-- 
Eduardo
