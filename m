Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2445AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 23:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF49F205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVo+97gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF49F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1eDs-0003jF-3S
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 19:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k1eDG-0003Ej-4q
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 19:13:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k1eDC-000843-JZ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 19:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596237192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIeVg7hV8/YXtrLLsERRgL4hSqd76ck4OF6tNpA3w5o=;
 b=QVo+97gZ+GkKQGT8kIT70E2pTeSUnWxzhjP2eBa/otvaKfN9k1ta6FeDnUxcLFSqSFXIBJ
 LYuu4Xr+FmLf1YjG9oG21m0HLLDNvB02xPQawxuaxrM84AIYmuTb5tSVF+E8Z/AgKKXSaD
 YAy26JEdJpDwluMDmDQG+xsGAd9bEoA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-WMIi6JWHMHG3m3MxvanUSw-1; Fri, 31 Jul 2020 19:13:07 -0400
X-MC-Unique: WMIi6JWHMHG3m3MxvanUSw-1
Received: by mail-oi1-f200.google.com with SMTP id q28so5034583oij.16
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 16:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QIeVg7hV8/YXtrLLsERRgL4hSqd76ck4OF6tNpA3w5o=;
 b=EQ+c29w6BNjY0yczRdYdlcShNXTo9TJ852OZnDIofhP98cCfiDOly86bNLcqGtB6yC
 +AjsbdKiEBxyumCh1Pz7Q4YD3dvWgVptZXNwlwUkmuD6WidL63tA7Nrt4w+r5CsokkEY
 ybL4N5+mZVQK0EiPFetTDD3mYpMtoHSAfEEZRitLCp+o4hJYTAeCGEiorbdJLFTV0eQF
 3aAwBhpzllSbNL73ByU/nYPPg2LXtI5SnIalnyNj+6XiCvJq1iegSbuf/yCJ8GSYW66v
 oDSKZImQH0A9kdMQRc9TuKYcXODWdT689a/lP2rHUAmdkxoUu1606se3AgH8SRbey97y
 SADA==
X-Gm-Message-State: AOAM530rdVZQbaN0bPXly4hAMraEGXsAnYcoto6wHt+JgBF14o160rxZ
 gh/0rPIC8e/BSbfHHYk9NRXa2gU3rhTH/TTM7HF6bzlmB8Q0mXnXYpk/cmhoZ7CCV0rGz80bvYU
 gYmeImRo6Ffby89QdcDpWri7b73IEKzw=
X-Received: by 2002:a9d:148:: with SMTP id 66mr4809630otu.132.1596237186571;
 Fri, 31 Jul 2020 16:13:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPDLYlUgU8KtA4KzIx9TCQ6WsiDDB5e5sK6SRvoJjP1ju8Sc5DTdkXlxolvEe90TB5XsUz6fjdRmXWQELUyn0=
X-Received: by 2002:a9d:148:: with SMTP id 66mr4809605otu.132.1596237186193;
 Fri, 31 Jul 2020 16:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
In-Reply-To: <20200730093732.GB3477223@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 1 Aug 2020 02:12:49 +0300
Message-ID: <CAMRbyysFSFKSOXvYbxAvyf_pqzAxA0KpEgcoJ+5bwa3DbA3x6g@mail.gmail.com>
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 19:13:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 12:38 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Thu, Jul 30, 2020 at 11:07:26AM +0200, Markus Armbruster wrote:
> > Andrea Bolognani <abologna@redhat.com> writes:
> >
> > > The various schemas included in QEMU use a JSON-based format which
> > > is, however, strictly speaking not valid JSON.
> > >
> > > As a consequence, when vim tries to apply syntax highlight rules
> > > for JSON (as guessed from the file name), the result is an unreadable
> > > mess which mostly consist of red markers pointing out supposed errors
> > > in, well, pretty much everything.
> > >
> > > Using Python syntax highlighting produces much better results, and
> > > in fact these files already start with specially-formatted comments
> > > that instruct Emacs to process them as if they were Python files.
> > >
> > > This commit adds the equivalent special comments for vim.
> > >
> > > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
>
> Given that we already have emacs mode-lines, I see no reason to
> not also have vim mode-lines, so regardless of the deeper discussion
> I think this is patch is fine to merge in the short term
>
>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> > Naming QAPI schema files .json even though their contents isn't was a
> > mistake.  Correcting it would be a pain.  If we correct it, then the
> > sooner the better.
> >
> > Renaming them to .py gives decent editor support out of the box.  Their
> > contents isn't quite Python, though: true vs. True, false vs. False.  D=
o
> > we care?  Only a few dozen occurences; they could be adjusted.
> >
> > Renaming them to .qapi would perhaps be less confusing, for the price o=
f
> > "out of the box".
>
> IMHO, the critical rule is that if you a pick a particular file extension
> associated with an existing language, you absolutely MUST BE compliant
> with that language.
>
> We fail at compliance with both JSON and Python because we're actually
> using our own DSL (domain specific language).
>
> IOW if we're going to stick with our current file format, then we should
> be naming them .qapi. We can still use an editor mode line if we want to
> claim we're approximately equiv to another language, but we can't be
> surprised if editors get upset.
>
>
> The bigger question is whether having our own DSL is justified ?
>
> I'm *really* sceptical that it is.
>
>
> We can't use JSON because it lacks comments. So we invented our own
> psuedo-JSON parser that supported comments, and used ' instead of "
> for some reason. We also needed to be able to parse a sequence of
> multiple JSON documents in one file. We should have just picked a
> different language because JSON clearly didn't do what we eneeded.
>
> You suggest naming them .py. If we do that, we must declare that they
> are literally Python code and modify them so that we can load the
> files straight into the python intepretor as code, and not parse
> them as data. I feel unhappy about treating data as code though.
>
>
> While JSON doesn't do what we need, its second-cousin YAML is a more
> flexible format. Taking one example
>
> ---
> ##
> # @ImageInfoSpecificQCow2:
> #
> # @compat: compatibility level
> #
> # ...snip...
> #
> # Since: 1.7
> ##
> struct: ImageInfoSpecificQCow2
> data:
>   compat: str
>   "*data-file": str
>   "*data-file-raw": bool
>   "*lazy-refcounts": bool
>   "*corrupt": bool
>   refcount-bits: int
>   "*encrypt": ImageInfoSpecificQCow2Encryption
>   "*bitmaps":
>     - Qcow2BitmapInfo
>   compression-type: Qcow2CompressionType
>
>
> Then we could use a regular off the shelf YAML parser in python.
>
> The uglyiness with quotes is due to the use of "*". Slightly less ugly
> if we simply declare that quotes are always used, even where they're
> not strictly required.
>
> struct: ImageInfoSpecificQCow2
> data:
>   "compat": "str"
>   "*data-file": "str"
>   "*data-file-raw": "bool"
>   "*lazy-refcounts": "bool"
>   "*corrupt": "bool"
>   "refcount-bits": "int"
>   "*encrypt": "ImageInfoSpecificQCow2Encryption"
>   "*bitmaps":
>     - "Qcow2BitmapInfo"
>   "compression-type": "Qcow2CompressionType"
>
> With the use of "---" to denote the start of document, we have no trouble
> parsing our files which would actually be a concatenation of multiple
> documents. The python YAML library provides the easy yaml.load_all()
> method.

We had the same issue in vdsm. Someone ported qemu "json" schema to vdsm,
probbay when the plan was to add C API to vdsm, which never happened.

My first patch to vdsm was fixing the parser for this "json" format,
because it used to
get in an endless loop if an unknown token was found. We hated this
format, and finally
replaced it with yaml. But we did not keep the comments since they
duplicate data
which is already in the json part, and not portable to other formats.

Here is the patch adding schema convertor from qemu "json" format to
standard yaml:
https://github.com/oVirt/vdsm/commit/e57b69e72987c0929b20306c454835b52b5eb7=
ee

The current version of the new yaml based schema:
https://github.com/oVirt/vdsm/blob/master/lib/vdsm/api/vdsm-api.yml

We don't use comments, so the yaml is portable to json or regular
python dict. In fact,
we use the schama in as a pickle of the parsed schema for 5 times
faster loading, which
is important since we use the schema in the command line client.

Having the comments part of the schema allows nice things like
verifying requests and
generating help messages directly from the schema. This is not a good
example before
our implementation is poor, but:

$ vdsm-client Host getDeviceList -h
usage: vdsm-client Host getDeviceList [-h] [arg=3Dvalue [arg=3Dvalue ...]]

positional arguments:
  arg=3Dvalue   storageType: Only return devices of this type
              guids: Only return info on specific list of block device GUID=
s
              checkStatus: Indicates if device status should be checked


              JSON representation:
              {
                  "storageType": {
                      "BlockDeviceType": "enum ['FCP', 'MIXED', 'iSCSI']"
                  },
                  "guids": [
                      "string",
                      {}
                  ],
                  "checkStatus": "boolean"
              }

optional arguments:
  -h, --help  show this help message and exit

vdsm-client knows nothing about vdsm API and we never have to change
it, because it generates
the command line interface and the help messages from the schema on
the fly, and its input and
output is json.

vdsm/client.py is similar, providing vdsm API without knowing anything
about the API, or requiring
changes when APIs are added or modified, because everything is done by
inspecting the schema:

>>> from vdsm import client
>>> c =3D client.connect("localhost")
>>> c.Host.getDeviceList(storageType=3D"FCP", checkStatus=3DFalse)
[]
>>> print(c.Host)
<vdsm.client.Namespace object at 0x7fcda017fa58>
>>> print(c.Host.getDeviceList)
functools.partial(<bound method _Client._call of <vdsm.client._Client
object at 0x7fcda757e0f0>>, 'Host', 'getDeviceList')

I think inventing DSLs and developing tools is wrong. Use standard
format and tools and spend
time on the core of the project.

Nir


