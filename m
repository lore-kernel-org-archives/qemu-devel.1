Received: from eggs.gnu.org ([2001:4830:134:3::10]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cijk1-0007ow-VO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cijjv-0002c6-88
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:31:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1488254329.git.jcody@redhat.com>
	<cover.1488254329.git.jcody@redhat.com>
	<64a3308bbe51f78ccd2a53b30e8ba576e979ac4f.1488254329.git.jcody@redhat.com>
	<87shmyxu3h.fsf@dusky.pond.sub.org>
	<20170228144228.GB15696@localhost.localdomain>
Date: Tue, 28 Feb 2017 16:30:51 +0100
In-Reply-To: <20170228144228.GB15696@localhost.localdomain> (Jeff Cody's
	message of "Tue, 28 Feb 2017 09:42:28 -0500")
Message-ID: <87tw7etjro.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] block/rbd: add support for
 'mon_host', 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com

Jeff Cody <jcody@redhat.com> writes:

> On Tue, Feb 28, 2017 at 03:34:10PM +0100, Markus Armbruster wrote:
>> Starting with just the QAPI schema.
>> 
>> Jeff Cody <jcody@redhat.com> writes:
>> 
>> > This adds support for three additional options that may be specified
>> > by QAPI in blockdev-add:
>> >
>> >     server: host, port
>> >     auth method: either 'cephx' or 'none'
>> >
>> > The "server" and "auth-supported" QAPI parameters are arrays.  To conform
>> > with the rados API, the array items are join as a single string with a ';'
>> > character as a delimiter when setting the configuration values.
>> >
>> > Signed-off-by: Jeff Cody <jcody@redhat.com>
>> > ---
>> [...]
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index f152953..5f74f92 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -2666,6 +2666,28 @@
>> >              '*header-digest': 'IscsiHeaderDigest',
>> >              '*timeout': 'int' } }
>> >  
>> > +
>> > +##
>> > +# @RbdAuthSupport:
>> > +#
>> > +# An enumeration of RBD auth support
>> > +#
>> > +# Since: 2.9
>> > +##
>> > +{ 'enum': 'RbdAuthSupport',
>> > +  'data': [ 'cephx', 'none' ] }
>> > +
>> > +
>> > +##
>> > +# @RbdAuthMethod:
>> > +#
>> > +# An enumeration of rados auth_supported types
>> > +#
>> > +# Since: 2.9
>> > +##
>> > +{ 'struct': 'RbdAuthMethod',
>> > +  'data': { 'auth': 'RbdAuthSupport' } }
>> > +
>> 
>> Any particular reason for wrapping the enum in a struct?  Do you
>> envisage adding members to the struct?
>>
>
> I am going to admit, mainly it was my frustration with trying to deal with a
> qapi array of just enums in a QDict, and structs was more straightforward.
> What is the best way to parse an array of enums inside a QDict?  Do you need
> to extract the subqdict via qdict_extract_subqdict() still?

I admit I'm not so familiar with the block layer's QObject mangling, and
the helper functions we've grown to support that.

I *am* familiar with QAPI visitors (I better be, I maintain the
subsystem), and they are my preferred tool to go from QObject to C data
structures and back.

The "to C" direction uses a QObject input visitor.  Roughly like this:

    Error *err = NULL;
    Visitor *v;
    QapiType *qapi;

    v = qobject_input_visitor_new(qobj);
    visit_type_QapiType(v, NULL, &qapi, &err);
    visit_free(v);

You now either got an Error object in @err, or a QapiType object in
@qapi.

To free the QapiType:

    qapi_free_QapiType(qapi);

The QapiType for ['RbdAuthSupport'] (i.e. list of enum RbdAuthSupport) is
called RbdAuthSupportList, and should look like this:

    struct RbdAuthSupportList {
        RbdAuthSupportList *next;
        RbdAuthSupport value;
    };

The next thing I have to admit is that I fail to see where you're
dealing "with a qapi array of just enums in a QDict".  Can you help?

>> >  ##
>> >  # @BlockdevOptionsRbd:
>> >  #
>> > @@ -2681,6 +2703,11 @@
>> >  #
>> >  # @user:               #optional Ceph id name.
>> >  #
>> > +# @server:             #optional Monitor host address and port.  This maps
>> > +#                      to the "mon_host" Ceph option.
>> 
>> Suggest something like "Monitor addresses", for consistency with how we
>> document *SocketAddress members elsewhere, and plural to hint at it
>> being a list, not just one.
>> 
>
> OK, thanks.
>
>> > +#
>> > +# @auth-supported:     #optional Authentication supported.
>> > +#
>> >  # @password-secret:    #optional The ID of a QCryptoSecret object providing
>> >  #                      the password for the login.
>> >  #
>> > @@ -2692,6 +2719,8 @@
>> >              '*conf': 'str',
>> >              '*snapshot': 'str',
>> >              '*user': 'str',
>> > +            '*server': ['InetSocketAddress'],
>> > +            '*auth-supported': ['RbdAuthMethod'],
>> >              '*password-secret': 'str' } }
>> >  
>> >  ##
