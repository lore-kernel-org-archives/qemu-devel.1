Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C6C2D0E0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B9020709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOpR/Bzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B9020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwHA-0005l8-9m
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEM-0000ek-ED
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEH-0006a1-Rs
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599166389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5WQ0sTufb3hOWOiRduXcm2dy80qBqfB9xlUEtF7TVs=;
 b=fOpR/BzpQlRMaY/64YX5E+BRtyz4R3HVnisslKZ0zbng3a1JrDzv0+jV18atfumid3RpOb
 tmj1LPPplSHw2Kanvsa0UG6lZr5KQaXfLO3+SPtR7OMoE1TkuNqyv6ZnJwDgHKruh28BQH
 tTvAY0oC0Dj9bUxH0VwjbbaO/D4b+zQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-nukytq-UMV2CP4Kv-8MigA-1; Thu, 03 Sep 2020 16:53:01 -0400
X-MC-Unique: nukytq-UMV2CP4Kv-8MigA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0703281CBF1;
 Thu,  3 Sep 2020 20:53:01 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EBF27E411;
 Thu,  3 Sep 2020 20:53:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/27] codeconverter: script for automating QOM code cleanups
Date: Thu,  3 Sep 2020 16:52:26 -0400
Message-Id: <20200903205247.1667472-7-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
References: <20200903205247.1667472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This started as a simple script that scanned for regular
expressions, but became more and more complex when exceptions to
the rules were found.

I don't know if this should be maintained in the QEMU source tree
long term (maybe it can be reused for other code transformations
that Coccinelle can't handle).  In either case, this is included
as part of the patch series to document how exactly the automated
code transformations in the next patches were done.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200831210740.126168-7-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .../codeconverter/codeconverter/__init__.py   |   0
 .../codeconverter/codeconverter/patching.py   | 397 +++++++++++
 .../codeconverter/codeconverter/qom_macros.py | 652 ++++++++++++++++++
 .../codeconverter/qom_type_info.py            | 434 ++++++++++++
 .../codeconverter/codeconverter/regexps.py    | 118 ++++
 .../codeconverter/test_patching.py            | 105 +++
 .../codeconverter/test_regexps.py             | 282 ++++++++
 scripts/codeconverter/codeconverter/utils.py  |  72 ++
 scripts/codeconverter/converter.py            | 123 ++++
 MAINTAINERS                                   |   5 +
 10 files changed, 2188 insertions(+)
 create mode 100644 scripts/codeconverter/codeconverter/__init__.py
 create mode 100644 scripts/codeconverter/codeconverter/patching.py
 create mode 100644 scripts/codeconverter/codeconverter/qom_macros.py
 create mode 100644 scripts/codeconverter/codeconverter/qom_type_info.py
 create mode 100644 scripts/codeconverter/codeconverter/regexps.py
 create mode 100644 scripts/codeconverter/codeconverter/test_patching.py
 create mode 100644 scripts/codeconverter/codeconverter/test_regexps.py
 create mode 100644 scripts/codeconverter/codeconverter/utils.py
 create mode 100755 scripts/codeconverter/converter.py

diff --git a/scripts/codeconverter/codeconverter/__init__.py b/scripts/codeconverter/codeconverter/__init__.py
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/scripts/codeconverter/codeconverter/patching.py b/scripts/codeconverter/codeconverter/patching.py
new file mode 100644
index 0000000000..627a1a1b04
--- /dev/null
+++ b/scripts/codeconverter/codeconverter/patching.py
@@ -0,0 +1,397 @@
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+from typing import IO, Match, NamedTuple, Optional, Literal, Iterable, Type, Dict, List, Any, TypeVar, NewType, Tuple
+from pathlib import Path
+from itertools import chain
+from tempfile import NamedTemporaryFile
+import os
+import re
+import subprocess
+from io import StringIO
+
+import logging
+logger = logging.getLogger(__name__)
+DBG = logger.debug
+INFO = logger.info
+WARN = logger.warning
+ERROR = logger.error
+
+from .utils import *
+
+T = TypeVar('T')
+
+class Patch(NamedTuple):
+    # start inside file.original_content
+    start: int
+    # end position inside file.original_content
+    end: int
+    # replacement string for file.original_content[start:end]
+    replacement: str
+
+IdentifierType = Literal['type', 'symbol', 'include', 'constant']
+class RequiredIdentifier(NamedTuple):
+    type: IdentifierType
+    name: str
+
+class FileMatch:
+    """Base class for regex matches
+
+    Subclasses just need to set the `regexp` class attribute
+    """
+    regexp: Optional[str] = None
+
+    def __init__(self, f: 'FileInfo', m: Match) -> None:
+        self.file: 'FileInfo' = f
+        self.match: Match = m
+
+    @property
+    def name(self) -> str:
+        if 'name' not in self.match.groupdict():
+            return '[no name]'
+        return self.group('name')
+
+    @classmethod
+    def compiled_re(klass):
+        return re.compile(klass.regexp, re.MULTILINE)
+
+    def start(self) -> int:
+        return self.match.start()
+
+    def end(self) -> int:
+        return self.match.end()
+
+    def line_col(self) -> LineAndColumn:
+        return self.file.line_col(self.start())
+
+    def group(self, *args):
+        return self.match.group(*args)
+
+    def log(self, level, fmt, *args) -> None:
+        pos = self.line_col()
+        logger.log(level, '%s:%d:%d: '+fmt, self.file.filename, pos.line, pos.col, *args)
+
+    def debug(self, fmt, *args) -> None:
+        self.log(logging.DEBUG, fmt, *args)
+
+    def info(self, fmt, *args) -> None:
+        self.log(logging.INFO, fmt, *args)
+
+    def warn(self, fmt, *args) -> None:
+        self.log(logging.WARNING, fmt, *args)
+
+    def error(self, fmt, *args) -> None:
+        self.log(logging.ERROR, fmt, *args)
+
+    def sub(self, original: str, replacement: str) -> str:
+        """Replace content
+
+        XXX: this won't use the match position, but will just
+        replace all strings that look like the original match.
+        This should be enough for all the patterns used in this
+        script.
+        """
+        return original.replace(self.group(0), replacement)
+
+    def sanity_check(self) -> None:
+        """Sanity check match, and print warnings if necessary"""
+        pass
+
+    def replacement(self) -> Optional[str]:
+        """Return replacement text for pattern, to use new code conventions"""
+        return None
+
+    def make_patch(self, replacement: str) -> 'Patch':
+        """Make patch replacing the content of this match"""
+        return Patch(self.start(), self.end(), replacement)
+
+    def make_subpatch(self, start: int, end: int, replacement: str) -> 'Patch':
+        return Patch(self.start() + start, self.start() + end, replacement)
+
+    def make_removal_patch(self) -> 'Patch':
+        """Make patch removing contents of match completely"""
+        return self.make_patch('')
+
+    def append(self, s: str) -> 'Patch':
+        """Make patch appending string after this match"""
+        return Patch(self.end(), self.end(), s)
+
+    def prepend(self, s: str) -> 'Patch':
+        """Make patch prepending string before this match"""
+        return Patch(self.start(), self.start(), s)
+
+    def gen_patches(self) -> Iterable['Patch']:
+        """Patch source code contents to use new code patterns"""
+        replacement = self.replacement()
+        if replacement is not None:
+            yield self.make_patch(replacement)
+
+    @classmethod
+    def has_replacement_rule(klass) -> bool:
+        return (klass.gen_patches is not FileMatch.gen_patches
+                or klass.replacement is not FileMatch.replacement)
+
+    def contains(self, other: 'FileMatch') -> bool:
+        return other.start() >= self.start() and other.end() <= self.end()
+
+    def __repr__(self) -> str:
+        start = self.file.line_col(self.start())
+        end = self.file.line_col(self.end() - 1)
+        return '<%s %s at %d:%d-%d:%d: %r>' % (self.__class__.__name__,
+                                                    self.name,
+                                                    start.line, start.col,
+                                                    end.line, end.col, self.group(0)[:100])
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        """Can be implemented by subclasses to keep track of identifier references
+
+        This method will be used by the code that moves declarations around the file,
+        to make sure we find the right spot for them.
+        """
+        raise NotImplementedError()
+
+    def provided_identifiers(self) -> Iterable[RequiredIdentifier]:
+        """Can be implemented by subclasses to keep track of identifier references
+
+        This method will be used by the code that moves declarations around the file,
+        to make sure we find the right spot for them.
+        """
+        raise NotImplementedError()
+
+    @classmethod
+    def find_matches(klass, content: str) -> Iterable[Match]:
+        """Generate match objects for class
+
+        Might be reimplemented by subclasses if they
+        intend to look for matches using a different method.
+        """
+        return klass.compiled_re().finditer(content)
+
+    @property
+    def allfiles(self) -> 'FileList':
+        return self.file.allfiles
+
+def all_subclasses(c: Type[FileMatch]) -> Iterable[Type[FileMatch]]:
+    for sc in c.__subclasses__():
+        yield sc
+        yield from all_subclasses(sc)
+
+def match_class_dict() -> Dict[str, Type[FileMatch]]:
+    d = dict((t.__name__, t) for t in all_subclasses(FileMatch))
+    return d
+
+def names(matches: Iterable[FileMatch]) -> Iterable[str]:
+    return [m.name for m in matches]
+
+class PatchingError(Exception):
+    pass
+
+class OverLappingPatchesError(PatchingError):
+    pass
+
+def apply_patches(s: str, patches: Iterable[Patch]) -> str:
+    """Apply a sequence of patches to string
+
+    >>> apply_patches('abcdefg', [Patch(2,2,'xxx'), Patch(0, 1, 'yy')])
+    'yybxxxcdefg'
+    """
+    r = StringIO()
+    last = 0
+    for p in sorted(patches):
+        DBG("Applying patch at position %d (%s) - %d (%s): %r",
+            p.start, line_col(s, p.start),
+            p.end, line_col(s, p.end),
+            p.replacement)
+        if last > p.start:
+            raise OverLappingPatchesError("Overlapping patch at position %d (%s), last patch at %d (%s)" % \
+                (p.start, line_col(s, p.start), last, line_col(s, last)))
+        r.write(s[last:p.start])
+        r.write(p.replacement)
+        last = p.end
+    r.write(s[last:])
+    return r.getvalue()
+
+class RegexpScanner:
+    def __init__(self) -> None:
+        self.match_index: Dict[Type[Any], List[FileMatch]] = {}
+        self.match_name_index: Dict[Tuple[Type[Any], str, str], Optional[FileMatch]] = {}
+
+    def _find_matches(self, klass: Type[Any]) -> Iterable[FileMatch]:
+        raise NotImplementedError()
+
+    def matches_of_type(self, t: Type[T]) -> List[T]:
+        if t not in self.match_index:
+            self.match_index[t] = list(self._find_matches(t))
+        return  self.match_index[t] # type: ignore
+
+    def find_match(self, t: Type[T], name: str, group: str='name') -> Optional[T]:
+        indexkey = (t, name, group)
+        if indexkey in self.match_name_index:
+            return self.match_name_index[indexkey] # type: ignore
+        r: Optional[T] = None
+        for m in self.matches_of_type(t):
+            assert isinstance(m, FileMatch)
+            if m.group(group) == name:
+                r = m # type: ignore
+        self.match_name_index[indexkey] = r # type: ignore
+        return r
+
+    def reset_index(self) -> None:
+        self.match_index.clear()
+        self.match_name_index.clear()
+
+class FileInfo(RegexpScanner):
+    filename: Path
+    original_content: Optional[str] = None
+
+    def __init__(self, files: 'FileList', filename: os.PathLike, force:bool=False) -> None:
+        super().__init__()
+        self.allfiles = files
+        self.filename = Path(filename)
+        self.patches: List[Patch] = []
+        self.force = force
+
+    def __repr__(self) -> str:
+        return f'<FileInfo {repr(self.filename)}>'
+
+    def line_col(self, start: int) -> LineAndColumn:
+        """Return line and column for a match object inside original_content"""
+        return line_col(self.original_content, start)
+
+    def _find_matches(self, klass: Type[Any]) -> List[FileMatch]:
+        """Build FileMatch objects for each match of regexp"""
+        if not hasattr(klass, 'regexp') or klass.regexp is None:
+            return []
+        assert hasattr(klass, 'regexp')
+        DBG("%s: scanning for %s", self.filename, klass.__name__)
+        DBG("regexp: %s", klass.regexp)
+        matches = [klass(self, m) for m in klass.find_matches(self.original_content)]
+        DBG('%s: %d matches found for %s: %s', self.filename, len(matches),
+            klass.__name__,' '.join(names(matches)))
+        return matches
+
+    def find_match(self, t: Type[T], name: str, group: str='name') -> Optional[T]:
+        for m in self.matches_of_type(t):
+            assert isinstance(m, FileMatch)
+            if m.group(group) == name:
+                return m # type: ignore
+        return None
+
+    def reset_content(self, s:str):
+        self.original_content = s
+        self.patches.clear()
+        self.reset_index()
+        self.allfiles.reset_index()
+
+    def load(self) -> None:
+        if self.original_content is not None:
+            return
+        with open(self.filename, 'rt') as f:
+            self.reset_content(f.read())
+
+    @property
+    def all_matches(self) -> Iterable[FileMatch]:
+        lists = list(self.match_index.values())
+        return (m for l in lists
+                  for m in l)
+
+    def scan_for_matches(self, class_names: Optional[List[str]]=None) -> None:
+        DBG("class names: %r", class_names)
+        class_dict = match_class_dict()
+        if class_names is None:
+            DBG("default class names")
+            class_names = list(name for name,klass in class_dict.items()
+                               if klass.has_replacement_rule())
+        DBG("class_names: %r", class_names)
+        for cn in class_names:
+            matches = self.matches_of_type(class_dict[cn])
+            if len(matches) > 0:
+                DBG('%s: %d matches found for %s: %s', self.filename,
+                     len(matches), cn, ' '.join(names(matches)))
+
+    def gen_patches(self) -> None:
+        for m in self.all_matches:
+            for i,p in enumerate(m.gen_patches()):
+                DBG("patch %d generated by %r:", i, m)
+                DBG("replace contents at %s-%s with %r",
+                    self.line_col(p.start), self.line_col(p.end), p.replacement)
+                self.patches.append(p)
+
+    def patch_content(self, max_passes=0, class_names: Optional[List[str]]=None) -> None:
+        """Multi-pass content patching loop
+
+        We run multiple passes because there are rules that will
+        delete init functions once they become empty.
+        """
+        passes = 0
+        total_patches  = 0
+        DBG("max_passes: %r", max_passes)
+        while not max_passes or max_passes <= 0 or passes < max_passes:
+            passes += 1
+            self.scan_for_matches(class_names)
+            self.gen_patches()
+            DBG("patch content: pass %d: %d patches generated", passes, len(self.patches))
+            total_patches += len(self.patches)
+            if not self.patches:
+                break
+            try:
+                self.apply_patches()
+            except PatchingError:
+                logger.exception("%s: failed to patch file", self.filename)
+        DBG("%s: %d patches applied total in %d passes", self.filename, total_patches, passes)
+
+    def apply_patches(self) -> None:
+        """Replace self.original_content after applying patches from self.patches"""
+        self.reset_content(self.get_patched_content())
+
+    def get_patched_content(self) -> str:
+        assert self.original_content is not None
+        return apply_patches(self.original_content, self.patches)
+
+    def write_to_file(self, f: IO[str]) -> None:
+        f.write(self.get_patched_content())
+
+    def write_to_filename(self, filename: os.PathLike) -> None:
+        with open(filename, 'wt') as of:
+            self.write_to_file(of)
+
+    def patch_inplace(self) -> None:
+        newfile = self.filename.with_suffix('.changed')
+        self.write_to_filename(newfile)
+        os.rename(newfile, self.filename)
+
+    def show_diff(self) -> None:
+        with NamedTemporaryFile('wt') as f:
+            self.write_to_file(f)
+            f.flush()
+            subprocess.call(['diff', '-u', self.filename, f.name])
+
+    def ref(self):
+        return TypeInfoReference
+
+class FileList(RegexpScanner):
+    def __init__(self):
+        super().__init__()
+        self.files: List[FileInfo] = []
+
+    def extend(self, *args, **kwargs):
+        self.files.extend(*args, **kwargs)
+
+    def __iter__(self):
+        return iter(self.files)
+
+    def _find_matches(self, klass: Type[Any]) -> Iterable[FileMatch]:
+        return chain(*(f._find_matches(klass) for f in self.files))
+
+    def find_file(self, name) -> Optional[FileInfo]:
+        """Get file with path ending with @name"""
+        nameparts = Path(name).parts
+        for f in self.files:
+            if f.filename.parts[:len(nameparts)] == nameparts:
+                return f
+        else:
+            return None
\ No newline at end of file
diff --git a/scripts/codeconverter/codeconverter/qom_macros.py b/scripts/codeconverter/codeconverter/qom_macros.py
new file mode 100644
index 0000000000..68a33d5c6f
--- /dev/null
+++ b/scripts/codeconverter/codeconverter/qom_macros.py
@@ -0,0 +1,652 @@
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+import re
+from itertools import chain
+from typing import *
+
+from .regexps import *
+from .patching import *
+from .utils import *
+
+import logging
+logger = logging.getLogger(__name__)
+DBG = logger.debug
+INFO = logger.info
+WARN = logger.warning
+
+# simple expressions:
+
+RE_CONSTANT = OR(RE_STRING, RE_NUMBER)
+
+class ConstantDefine(FileMatch):
+    """Simple #define preprocessor directive for a constant"""
+    # if the macro contents are very simple, it might be included
+    # in the match group 'value'
+    regexp = S(r'^[ \t]*#[ \t]*define', CPP_SPACE, NAMED('name', RE_IDENTIFIER),
+               CPP_SPACE, NAMED('value', RE_CONSTANT), r'[ \t]*\n')
+
+    def provided_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('constant', self.group('name'))
+
+class TypeIdentifiers(NamedTuple):
+    """Type names found in type declarations"""
+    # TYPE_MYDEVICE
+    typename: Optional[str]
+    # MYDEVICE
+    uppercase: Optional[str] = None
+    # MyDevice
+    instancetype: Optional[str] = None
+    # MyDeviceClass
+    classtype: Optional[str] = None
+    # my_device
+    lowercase: Optional[str] = None
+
+    def allfields(self):
+        return tuple(getattr(self, f) for f in self._fields)
+
+    def merge(self, other: 'TypeIdentifiers') -> Optional['TypeIdentifiers']:
+        """Check if identifiers match, return new identifier with complete list"""
+        if any(not opt_compare(a, b) for a,b in zip(self, other)):
+            return None
+        return TypeIdentifiers(*(merge(a, b) for a,b in zip(self, other)))
+
+    def __str__(self) -> str:
+        values = ((f, getattr(self, f)) for f in self._fields)
+        s = ', '.join('%s=%s' % (f,v) for f,v in values if v is not None)
+        return f'{s}'
+
+    def check_consistency(self) -> List[str]:
+        """Check if identifiers are consistent with each other,
+        return list of problems (or empty list if everything seems consistent)
+        """
+        r = []
+        if self.typename is None:
+            r.append("typename (TYPE_MYDEVICE) is unavailable")
+
+        if self.uppercase is None:
+            r.append("uppercase name is unavailable")
+
+        if (self.instancetype is not None
+            and self.classtype is not None
+            and self.classtype != f'{self.instancetype}Class'):
+                r.append("class typedef %s doesn't match instance typedef %s" %
+                         (self.classtype, self.instancetype))
+
+        if (self.uppercase is not None
+            and self.typename is not None
+            and f'TYPE_{self.uppercase}' != self.typename):
+            r.append("uppercase name (%s) doesn't match type name (%s)" %
+                     (self.uppercase, self.typename))
+
+        return r
+
+class TypedefMatch(FileMatch):
+    """typedef declaration"""
+    def provided_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('type', self.group('name'))
+
+class SimpleTypedefMatch(TypedefMatch):
+    """Simple typedef declaration
+    (no replacement rules)"""
+    regexp = S(r'^[ \t]*typedef', SP,
+               NAMED('typedef_type', RE_TYPE), SP,
+               NAMED('name', RE_IDENTIFIER), r'\s*;[ \t]*\n')
+
+RE_MACRO_DEFINE = S(r'^[ \t]*#\s*define\s+', NAMED('name', RE_IDENTIFIER),
+                    r'\s*\(\s*', RE_IDENTIFIER, r'\s*\)', CPP_SPACE)
+
+RE_STRUCT_ATTRIBUTE = r'QEMU_PACKED'
+
+# This doesn't parse the struct definitions completely, it just assumes
+# the closing brackets are going to be in an unindented line:
+RE_FULL_STRUCT = S('struct', SP, M(RE_IDENTIFIER, n='?', name='structname'), SP,
+                   NAMED('body', r'{\n',
+                         # acceptable inside the struct body:
+                         # - lines starting with space or tab
+                         # - empty lines
+                         # - preprocessor directives
+                         # - comments
+                         OR(r'[ \t][^\n]*\n',
+                            r'#[^\n]*\n',
+                            r'\n',
+                            S(r'[ \t]*', RE_COMMENT, r'[ \t]*\n'),
+                            repeat='*?'),
+                         r'}', M(RE_STRUCT_ATTRIBUTE, SP, n='*')))
+RE_STRUCT_TYPEDEF = S(r'^[ \t]*typedef', SP, RE_FULL_STRUCT, SP,
+                      NAMED('name', RE_IDENTIFIER), r'\s*;[ \t]*\n')
+
+class FullStructTypedefMatch(TypedefMatch):
+    """typedef struct [SomeStruct] { ...} SomeType
+    Will be replaced by separate struct declaration + typedef
+    """
+    regexp = RE_STRUCT_TYPEDEF
+
+    def make_structname(self) -> str:
+        """Make struct name for struct+typedef split"""
+        name = self.group('structname')
+        if not name:
+            name = self.name
+        return name
+
+    def strip_typedef(self) -> Patch:
+        """generate patch that will strip typedef from the struct declartion
+
+        The caller is responsible for readding the typedef somewhere else.
+        """
+        name = self.make_structname()
+        body = self.group('body')
+        return self.make_patch(f'struct {name} {body};\n')
+
+    def make_simple_typedef(self) -> str:
+        structname = self.make_structname()
+        name = self.name
+        return f'typedef struct {structname} {name};\n'
+
+    def move_typedef(self, position) -> Iterator[Patch]:
+        """Generate patches to move typedef elsewhere"""
+        yield self.strip_typedef()
+        yield Patch(position, position, self.make_simple_typedef())
+
+    def split_typedef(self) -> Iterator[Patch]:
+        """Split into struct definition + typedef in-place"""
+        yield self.strip_typedef()
+        yield self.append(self.make_simple_typedef())
+
+class StructTypedefSplit(FullStructTypedefMatch):
+    """split struct+typedef declaration"""
+    def gen_patches(self) -> Iterator[Patch]:
+        if self.group('structname'):
+            yield from self.split_typedef()
+
+class DuplicatedTypedefs(SimpleTypedefMatch):
+    """Delete ALL duplicate typedefs (unsafe)"""
+    def gen_patches(self) -> Iterable[Patch]:
+        other_td = [td for td in chain(self.file.matches_of_type(SimpleTypedefMatch),
+                                       self.file.matches_of_type(FullStructTypedefMatch))
+                    if td.name == self.name]
+        DBG("other_td: %r", other_td)
+        if any(td.start() < self.start() for td in other_td):
+            # patch only if handling the first typedef
+            return
+        for td in other_td:
+            if isinstance(td, SimpleTypedefMatch):
+                DBG("other td: %r", td.match.groupdict())
+                if td.group('typedef_type') != self.group('typedef_type'):
+                    yield td.make_removal_patch()
+            elif isinstance(td, FullStructTypedefMatch):
+                DBG("other td: %r", td.match.groupdict())
+                if self.group('typedef_type') == 'struct '+td.group('structname'):
+                    yield td.strip_typedef()
+
+class QOMDuplicatedTypedefs(DuplicatedTypedefs):
+    """Delete duplicate typedefs if used by QOM type"""
+    def gen_patches(self) -> Iterable[Patch]:
+        qom_macros = [TypeCheckMacro, DeclareInstanceChecker, DeclareClassCheckers, DeclareObjCheckers]
+        qom_matches = chain(*(self.file.matches_of_type(t) for t in qom_macros))
+        in_use = any(RequiredIdentifier('type', self.name) in m.required_identifiers()
+                     for m in qom_matches)
+        if in_use:
+            yield from DuplicatedTypedefs.gen_patches(self)
+
+class QOMStructTypedefSplit(FullStructTypedefMatch):
+    """split struct+typedef declaration if used by QOM type"""
+    def gen_patches(self) -> Iterator[Patch]:
+        qom_macros = [TypeCheckMacro, DeclareInstanceChecker, DeclareClassCheckers, DeclareObjCheckers]
+        qom_matches = chain(*(self.file.matches_of_type(t) for t in qom_macros))
+        in_use = any(RequiredIdentifier('type', self.name) in m.required_identifiers()
+                     for m in qom_matches)
+        if in_use:
+            yield from self.split_typedef()
+
+def typedefs(file: FileInfo) -> Iterable[TypedefMatch]:
+    return (cast(TypedefMatch, m)
+            for m in chain(file.matches_of_type(SimpleTypedefMatch),
+                           file.matches_of_type(FullStructTypedefMatch)))
+
+def find_typedef(f: FileInfo, name: Optional[str]) -> Optional[TypedefMatch]:
+    if not name:
+        return None
+    for td in typedefs(f):
+        if td.name == name:
+            return td
+    return None
+
+CHECKER_MACROS = ['OBJECT_CHECK', 'OBJECT_CLASS_CHECK', 'OBJECT_GET_CLASS']
+CheckerMacroName = Literal['OBJECT_CHECK', 'OBJECT_CLASS_CHECK', 'OBJECT_GET_CLASS']
+
+RE_CHECK_MACRO = \
+    S(RE_MACRO_DEFINE,
+      OR(*CHECKER_MACROS, name='checker'),
+      M(r'\s*\(\s*', OR(NAMED('typedefname', RE_IDENTIFIER), RE_TYPE, name='c_type'), r'\s*,', CPP_SPACE,
+        OPTIONAL_PARS(RE_IDENTIFIER), r',', CPP_SPACE,
+        NAMED('qom_typename', RE_IDENTIFIER), r'\s*\)\n',
+        n='?', name='check_args'))
+
+EXPECTED_CHECKER_SUFFIXES: List[Tuple[CheckerMacroName, str]] = [
+    ('OBJECT_GET_CLASS', '_GET_CLASS'),
+    ('OBJECT_CLASS_CHECK', '_CLASS'),
+]
+
+class TypeCheckMacro(FileMatch):
+    """OBJECT_CHECK/OBJECT_CLASS_CHECK/OBJECT_GET_CLASS macro definitions
+    Will be replaced by DECLARE_*_CHECKERS macro
+    """
+    #TODO: handle and convert INTERFACE_CHECK macros
+    regexp = RE_CHECK_MACRO
+
+    @property
+    def checker(self) -> CheckerMacroName:
+        """Name of checker macro being used"""
+        return self.group('checker')
+
+    @property
+    def typedefname(self) -> Optional[str]:
+        return self.group('typedefname')
+
+    def find_typedef(self) -> Optional[TypedefMatch]:
+        return find_typedef(self.file, self.typedefname)
+
+    def sanity_check(self) -> None:
+        DBG("groups: %r", self.match.groups())
+        if not self.group('check_args'):
+            self.warn("type check macro not parsed completely: %s", self.name)
+            return
+        DBG("type identifiers: %r", self.type_identifiers)
+        if self.typedefname and self.find_typedef() is None:
+            self.warn("typedef used by %s not found", self.name)
+
+    def find_matching_macros(self) -> List['TypeCheckMacro']:
+        """Find other check macros that generate the same macro names
+
+        The returned list will always be sorted.
+        """
+        my_ids = self.type_identifiers
+        assert my_ids
+        return [m for m in self.file.matches_of_type(TypeCheckMacro)
+                if m.type_identifiers is not None
+                   and my_ids.uppercase is not None
+                   and (my_ids.uppercase == m.type_identifiers.uppercase
+                        or my_ids.typename == m.type_identifiers.typename)]
+
+    def merge_ids(self, matches: List['TypeCheckMacro']) -> Optional[TypeIdentifiers]:
+        """Try to merge info about type identifiers from all matches in a list"""
+        if not matches:
+            return None
+        r = matches[0].type_identifiers
+        if r is None:
+            return None
+        for m in matches[1:]:
+            assert m.type_identifiers
+            new = r.merge(m.type_identifiers)
+            if new is None:
+                self.warn("macro %s identifiers (%s) don't match macro %s (%s)",
+                          matches[0].name, r, m.name, m.type_identifiers)
+                return None
+            r = new
+        return r
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        if self.type_identifiers is None:
+            return
+        # to make sure typedefs will be moved above all related macros,
+        # return dependencies from all of them, not just this match
+        for m in self.find_matching_macros():
+            yield RequiredIdentifier('type', m.group('c_type'))
+            yield RequiredIdentifier('constant', m.group('qom_typename'))
+
+    @property
+    def type_identifiers(self) -> Optional[TypeIdentifiers]:
+        """Extract type identifier information from match"""
+        typename = self.group('qom_typename')
+        c_type = self.group('c_type')
+        if not typename or not c_type:
+            return None
+        typedef = self.group('typedefname')
+        classtype = None
+        instancetype = None
+        uppercase = None
+        expected_suffix = dict(EXPECTED_CHECKER_SUFFIXES).get(self.checker)
+
+        # here the available data depends on the checker macro being called:
+        # - we need to remove the suffix from the macro name
+        # - depending on the macro type, we know the class type name, or
+        #   the instance type name
+        if self.checker in ('OBJECT_GET_CLASS', 'OBJECT_CLASS_CHECK'):
+            classtype = c_type
+        elif self.checker == 'OBJECT_CHECK':
+            instancetype = c_type
+            uppercase = self.name
+        else:
+            assert False
+        if expected_suffix and self.name.endswith(expected_suffix):
+            uppercase = self.name[:-len(expected_suffix)]
+        return TypeIdentifiers(typename=typename, classtype=classtype,
+                               instancetype=instancetype, uppercase=uppercase)
+
+    def gen_patches(self) -> Iterable[Patch]:
+        if self.type_identifiers is None:
+            self.warn("couldn't extract type information from macro %s", self.name)
+            return
+
+        if self.name == 'INTERFACE_CLASS':
+            # INTERFACE_CLASS is special and won't be patched
+            return
+
+        for checker,suffix in EXPECTED_CHECKER_SUFFIXES:
+            if self.name.endswith(suffix):
+                if self.checker != checker:
+                    self.warn("macro %s is using macro %s instead of %s", self.name, self.checker, checker)
+                    return
+                break
+
+        matches = self.find_matching_macros()
+        DBG("found %d matching macros: %s", len(matches), ' '.join(m.name for m in matches))
+        # we will generate patches only when processing the first macro:
+        if matches[0].start != self.start:
+            DBG("skipping %s (will patch when handling %s)", self.name, matches[0].name)
+            return
+
+
+        ids = self.merge_ids(matches)
+        if ids is None:
+            DBG("type identifier mismatch, won't patch %s", self.name)
+            return
+
+        if not ids.uppercase:
+            self.warn("macro %s doesn't follow the expected name pattern", self.name)
+            return
+        if not ids.typename:
+            self.warn("macro %s: couldn't extract type name", self.name)
+            return
+
+        #issues = ids.check_consistency()
+        #if issues:
+        #    for i in issues:
+        #        self.warn("inconsistent identifiers: %s", i)
+
+        names = [n for n in (ids.instancetype, ids.classtype, ids.uppercase, ids.typename)
+                 if n is not None]
+        if len(set(names)) != len(names):
+            self.warn("duplicate names used by macro: %r", ids)
+            return
+
+        assert ids.classtype or ids.instancetype
+        assert ids.typename
+        assert ids.uppercase
+        if ids.classtype and ids.instancetype:
+            new_decl = (f'DECLARE_OBJ_CHECKERS({ids.instancetype}, {ids.classtype},\n'
+                        f'                     {ids.uppercase}, {ids.typename})\n')
+        elif ids.classtype:
+            new_decl = (f'DECLARE_CLASS_CHECKERS({ids.classtype}, {ids.uppercase},\n'
+                        f'                       {ids.typename})\n')
+        elif ids.instancetype:
+            new_decl = (f'DECLARE_INSTANCE_CHECKER({ids.instancetype}, {ids.uppercase},\n'
+                        f'                         {ids.typename})\n')
+        else:
+            assert False
+
+        # we need to ensure the typedefs are already available
+        issues = []
+        for t in [ids.instancetype, ids.classtype]:
+            if not t:
+                continue
+            if re.fullmatch(RE_STRUCT_TYPE, t):
+                self.info("type %s is not a typedef", t)
+                continue
+            td = find_typedef(self.file, t)
+            #if not td and self.allfiles.find_file('include/qemu/typedefs.h'):
+            #
+            if not td:
+                # it is OK if the typedef is in typedefs.h
+                f = self.allfiles.find_file('include/qemu/typedefs.h')
+                if f and find_typedef(f, t):
+                    self.info("typedef %s found in typedefs.h", t)
+                    continue
+
+                issues.append("couldn't find typedef %s" % (t))
+            elif td.start() > self.start():
+                issues.append("typedef %s need to be moved earlier in the file" % (td.name))
+
+        for issue in issues:
+            self.warn(issue)
+
+        if issues and not self.file.force:
+            return
+
+        # delete all matching macros and add new declaration:
+        for m in matches:
+            yield m.make_patch('')
+        for issue in issues:
+            yield self.prepend("/* FIXME: %s */\n" % (issue))
+        yield self.append(new_decl)
+
+class DeclareInstanceChecker(FileMatch):
+    """DECLARE_INSTANCE_CHECKER use
+    Will be replaced with DECLARE_OBJ_CHECKERS if possible
+    """
+    #TODO: replace lonely DECLARE_INSTANCE_CHECKER with DECLARE_OBJ_CHECKERS
+    #      if all types are found.
+    #      This will require looking up the correct class type in the TypeInfo
+    #      structs in another file
+    regexp = S(r'^[ \t]*DECLARE_INSTANCE_CHECKER\s*\(\s*',
+               NAMED('instancetype', RE_TYPE), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               OR(RE_IDENTIFIER, RE_STRING, RE_MACRO_CONCAT, RE_FUN_CALL, name='typename'), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        yield RequiredIdentifier('constant', self.group('typename'))
+        yield RequiredIdentifier('type', self.group('instancetype'))
+
+class DeclareClassCheckers(FileMatch):
+    """DECLARE_INSTANCE_CHECKER use"""
+    regexp = S(r'^[ \t]*DECLARE_CLASS_CHECKERS\s*\(\s*',
+               NAMED('classtype', RE_TYPE), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               OR(RE_IDENTIFIER, RE_STRING, RE_MACRO_CONCAT, RE_FUN_CALL, name='typename'), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        yield RequiredIdentifier('constant', self.group('typename'))
+        yield RequiredIdentifier('type', self.group('classtype'))
+
+class DeclareObjCheckers(FileMatch):
+    """DECLARE_OBJ_CHECKERS use
+    Will be replaced with OBJECT_DECLARE_TYPE if possible
+    """
+    #TODO: detect when OBJECT_DECLARE_SIMPLE_TYPE can be used
+    regexp = S(r'^[ \t]*DECLARE_OBJ_CHECKERS\s*\(\s*',
+               NAMED('instancetype', RE_TYPE), r'\s*,\s*',
+               NAMED('classtype', RE_TYPE), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               OR(RE_IDENTIFIER, RE_STRING, RE_MACRO_CONCAT, RE_FUN_CALL, name='typename'), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        yield RequiredIdentifier('constant', self.group('typename'))
+        yield RequiredIdentifier('type', self.group('classtype'))
+        yield RequiredIdentifier('type', self.group('instancetype'))
+
+    def gen_patches(self):
+        ids = TypeIdentifiers(uppercase=self.group('uppercase'),
+                              typename=self.group('typename'),
+                              classtype=self.group('classtype'),
+                              instancetype=self.group('instancetype'))
+        issues = ids.check_consistency()
+        if issues:
+            for i in issues:
+                self.warn("inconsistent identifiers: %s", i)
+            return
+
+        if self.group('typename') != 'TYPE_'+self.group('uppercase'):
+            self.warn("type %s mismatch with uppercase name %s", ids.typename, ids.uppercase)
+            return
+
+        typedefs = [(t,self.file.find_match(SimpleTypedefMatch, t))
+                    for t in (ids.instancetype, ids.classtype)]
+        for t,td in typedefs:
+            if td is None:
+                self.warn("typedef %s not found", t)
+                break
+            if td.start() > self.start():
+                self.warn("typedef %s needs to be move earlier in the file", t)
+                break
+            #HACK: check if typedef is used between its definition and the macro
+            #TODO: check if the only match is inside the "struct { ... }" declaration
+            if re.search(r'\b'+t+r'\b', self.file.original_content[td.end():self.start()]):
+                self.warn("typedef %s can't be moved, it is used before the macro", t)
+                break
+        else:
+            for t,td in typedefs:
+                yield td.make_removal_patch()
+
+            lowercase = ids.uppercase.lower()
+            # all is OK, we can replace the macro!
+            c = (f'OBJECT_DECLARE_TYPE({ids.instancetype}, {ids.classtype},\n'
+                 f'                    {lowercase}, {ids.uppercase})\n')
+            yield self.make_patch(c)
+
+class TrivialClassStruct(FileMatch):
+    """Trivial class struct"""
+    regexp = S(r'^[ \t]*struct\s*', NAMED('name', RE_IDENTIFIER),
+               r'\s*{\s*', NAMED('parent_struct', RE_IDENTIFIER), r'\s*parent(_class)?\s*;\s*};\n')
+
+class DeclareTypeName(FileMatch):
+    """DECLARE_TYPE_NAME usage"""
+    regexp = S(r'^[ \t]*DECLARE_TYPE_NAME\s*\(',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               OR(RE_IDENTIFIER, RE_STRING, RE_MACRO_CONCAT, RE_FUN_CALL, name='typename'),
+               r'\s*\);?[ \t]*\n')
+
+class ObjectDeclareType(FileMatch):
+    """OBJECT_DECLARE_TYPE usage
+    Will be replaced with OBJECT_DECLARE_SIMPLE_TYPE if possible
+    """
+    regexp = S(r'^[ \t]*OBJECT_DECLARE_TYPE\s*\(',
+               NAMED('instancetype', RE_TYPE), r'\s*,\s*',
+               NAMED('classtype', RE_TYPE), r'\s*,\s*',
+               NAMED('lowercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    def gen_patches(self):
+        DBG("groups: %r", self.match.groupdict())
+        trivial_struct = self.file.find_match(TrivialClassStruct, self.group('classtype'))
+        if trivial_struct:
+            d = self.match.groupdict().copy()
+            d['parent_struct'] = trivial_struct.group("parent_struct")
+            yield trivial_struct.make_removal_patch()
+            c = ("OBJECT_DECLARE_SIMPLE_TYPE(%(instancetype)s, %(lowercase)s,\n"
+                 "                           %(uppercase)s, %(parent_struct)s)\n" % d)
+            yield self.make_patch(c)
+
+def find_type_declaration(files: FileList, typename: str) -> Optional[FileMatch]:
+    """Find usage of DECLARE*CHECKER macro"""
+    for c in (DeclareInstanceChecker, DeclareClassCheckers, DeclareObjCheckers, DeclareTypeName):
+        d = files.find_match(c, name=typename, group='typename')
+        if d:
+            return d
+    return None
+
+
+class Include(FileMatch):
+    """#include directive"""
+    regexp = RE_INCLUDE
+    def provided_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', self.group('includepath'))
+
+class InitialIncludes(FileMatch):
+    """Initial #include block"""
+    regexp = S(RE_FILE_BEGIN,
+               M(SP, RE_COMMENTS,
+                 r'^[ \t]*#[ \t]*ifndef[ \t]+', RE_IDENTIFIER, r'[ \t]*\n',
+                 n='?', name='ifndef_block'),
+               M(SP, RE_COMMENTS,
+                 OR(RE_INCLUDE, RE_SIMPLEDEFINE),
+                 n='*', name='includes'))
+
+class SymbolUserList(NamedTuple):
+    definitions: List[FileMatch]
+    users: List[FileMatch]
+
+class MoveSymbols(FileMatch):
+    """Handle missing symbols
+    - Move typedefs and defines when necessary
+    - Add missing #include lines when necessary
+    """
+    regexp = RE_FILE_BEGIN
+
+    def gen_patches(self) -> Iterator[Patch]:
+        index: Dict[RequiredIdentifier, SymbolUserList] = {}
+        definition_classes = [SimpleTypedefMatch, FullStructTypedefMatch, ConstantDefine, Include]
+        user_classes = [TypeCheckMacro, DeclareObjCheckers, DeclareInstanceChecker, DeclareClassCheckers]
+
+        # first we scan for all symbol definitions and usage:
+        for dc in definition_classes:
+            defs = self.file.matches_of_type(dc)
+            for d in defs:
+                DBG("scanning %r", d)
+                for i in d.provided_identifiers():
+                    index.setdefault(i, SymbolUserList([], [])).definitions.append(d)
+        DBG("index: %r", list(index.keys()))
+        for uc in user_classes:
+            users = self.file.matches_of_type(uc)
+            for u in users:
+                for i in u.required_identifiers():
+                    index.setdefault(i, SymbolUserList([], [])).users.append(u)
+
+        # validate all symbols:
+        for i,ul in index.items():
+            if not ul.users:
+                # unused symbol
+                continue
+
+            # symbol not defined
+            if len(ul.definitions) == 0:
+                if i.type == 'include':
+                   includes, = self.file.matches_of_type(InitialIncludes)
+                   #FIXME: don't do this if we're already inside qom/object.h
+                   yield includes.append(f'#include {i.name}\n')
+                else:
+                    u.warn("definition of %s %s not found in file", i.type, i.name)
+                continue
+
+            # symbol defined twice:
+            if len(ul.definitions) > 1:
+                ul.definitions[1].warn("%s defined twice", i.name)
+                ul.definitions[0].warn("previously defined here")
+                continue
+
+            # symbol defined.  check if all users are after its definition:
+            assert len(ul.definitions) == 1
+            definition = ul.definitions[0]
+            DBG("handling repositioning of %r", definition)
+            earliest = min(ul.users, key=lambda u: u.start())
+            if earliest.start() > definition.start():
+                DBG("%r is OK", definition)
+                continue
+
+            DBG("%r needs to be moved", definition)
+            if isinstance(definition, SimpleTypedefMatch) \
+               or isinstance(definition, ConstantDefine):
+                # simple typedef or define can be moved directly:
+                yield definition.make_removal_patch()
+                yield earliest.prepend(definition.group(0))
+            elif isinstance(definition, FullStructTypedefMatch) \
+                 and definition.group('structname'):
+                # full struct typedef is more complex: we need to remove
+                # the typedef
+                yield from definition.move_typedef(earliest.start())
+            else:
+                definition.warn("definition of %s %s needs to be moved earlier in the file", i.type, i.name)
+                earliest.warn("definition of %s %s is used here", i.type, i.name)
+
diff --git a/scripts/codeconverter/codeconverter/qom_type_info.py b/scripts/codeconverter/codeconverter/qom_type_info.py
new file mode 100644
index 0000000000..fc02058739
--- /dev/null
+++ b/scripts/codeconverter/codeconverter/qom_type_info.py
@@ -0,0 +1,434 @@
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+import re
+from .regexps import *
+from .patching import *
+from .utils import *
+from .qom_macros import *
+
+TI_FIELDS = [ 'name', 'parent', 'abstract', 'interfaces',
+    'instance_size', 'instance_init', 'instance_post_init', 'instance_finalize',
+    'class_size', 'class_init', 'class_base_init', 'class_data']
+
+RE_TI_FIELD_NAME = OR(*TI_FIELDS)
+
+RE_TI_FIELD_INIT = S(r'[ \t]*', NAMED('comments', RE_COMMENTS),
+                     r'\.', NAMED('field', RE_TI_FIELD_NAME), r'\s*=\s*',
+                     NAMED('value', RE_EXPRESSION), r'[ \t]*,?[ \t]*\n')
+RE_TI_FIELDS = M(RE_TI_FIELD_INIT)
+
+RE_TYPEINFO_START = S(r'^[ \t]*', M(r'(static|const)\s+', name='modifiers'), r'TypeInfo\s+',
+                      NAMED('name', RE_IDENTIFIER), r'\s*=\s*{[ \t]*\n')
+RE_TYPEINFO_DEF = S(RE_TYPEINFO_START,
+                    M(NAMED('fields', RE_TI_FIELDS),
+                      SP, NAMED('endcomments', RE_COMMENTS),
+                      r'};?\n',
+                      n='?', name='fullspec'))
+
+ParsedArray = List[str]
+ParsedInitializerValue = Union[str, ParsedArray]
+class InitializerValue(NamedTuple):
+    raw: str
+    parsed: Optional[ParsedInitializerValue]
+    match: Optional[Match]
+TypeInfoInitializers = Dict[str, InitializerValue]
+
+def parse_array(m: Match) -> ParsedArray:
+    #DBG('parse_array: %r', m.group(0))
+    return [m.group('arrayitem') for m in re.finditer(RE_ARRAY_ITEM, m.group('arrayitems'))]
+
+def parse_initializer_value(m: Match, s: str) -> InitializerValue:
+    parsed: Optional[ParsedInitializerValue] = None
+    #DBG("parse_initializer_value: %r", s)
+    array = re.match(RE_ARRAY, s)
+    if array:
+        parsed = parse_array(array)
+    return InitializerValue(s, parsed, m)
+
+class TypeInfoVar(FileMatch):
+    """TypeInfo variable declaration with initializer
+    Will be replaced by OBJECT_DEFINE_TYPE_EXTENDED macro
+    (not implemented yet)
+    """
+    regexp = RE_TYPEINFO_DEF
+
+    @property
+    def initializers(self) -> Optional[TypeInfoInitializers]:
+        if getattr(self, '_inititalizers', None):
+            self._initializers: TypeInfoInitializers
+            return self._initializers
+        fields = self.group('fields')
+        if fields is None:
+            return None
+        d = dict((fm.group('field'), parse_initializer_value(fm, fm.group('value')))
+                  for fm in re.finditer(RE_TI_FIELD_INIT, fields))
+        self._initializers = d
+        return d
+
+    def is_static(self) -> bool:
+        return 'static' in self.group('modifiers')
+
+    def is_full(self) -> bool:
+        return bool(self.group('fullspec'))
+
+    def get_initializers(self) -> TypeInfoInitializers:
+        """Helper for code that needs to deal with missing initializer info"""
+        if self.initializers is None:
+            return {}
+        return self.initializers
+
+    def get_initializer_value(self, field: str) -> InitializerValue:
+        return self.get_initializers().get(field, InitializerValue('', '', None))
+
+    #def extract_identifiers(self) -> Optional[TypeIdentifiers]:
+    #    """Try to extract identifiers from names being used"""
+    #    DBG("extracting idenfiers from %s", self.name)
+        #uppercase = None
+        #if typename and re.fullmatch(RE_IDENTIFIER, typename) and typename.startswith("TYPE_"):
+        #    uppercase = typename[len('TYPE_'):]
+        #lowercase = None
+        #funcs = set()
+        #prefixes = set()
+        #for field,suffix in [('instance_init', '_init'),
+        #                     ('instance_finalize', '_finalize'),
+        #                     ('class_init', '_class_init')]:
+        #    if field not in values:
+        #        continue
+        #    func = values[field].raw
+        #    funcs.add(func)
+        #    if func.endswith(suffix):
+        #        prefixes.add(func[:-len(suffix)])
+        #    else:
+        #        self.warn("function name %s doesn't have expected %s suffix",
+        #                  func, suffix)
+        #if len(prefixes) == 1:
+        #    lowercase = prefixes.pop()
+        #elif len(prefixes) > 1:
+        #    self.warn("inconsistent function names: %s", ' '.join(funcs))
+
+        #.parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
+        #return TypeIdentifiers(typename=typename,
+        #                       uppercase=uppercase, lowercase=lowercase,
+        #                       instancetype=instancetype, classtype=classtype)
+
+    def append_field(self, field, value) -> Patch:
+        """Generate patch appending a field initializer"""
+        content = f'    .{field} = {value},\n'
+        return Patch(self.match.end('fields'), self.match.end('fields'),
+                     content)
+
+    def patch_field(self, field: str, replacement: str) -> Patch:
+        """Generate patch replacing a field initializer"""
+        values = self.initializers
+        assert values
+        value = values.get(field)
+        assert value
+        fm = value.match
+        assert fm
+        fstart = self.match.start('fields') + fm.start()
+        fend = self.match.start('fields') + fm.end()
+        return Patch(fstart, fend, replacement)
+
+    def gen_patches(self) -> Iterable[Patch]:
+        values = self.initializers
+        if values is None:
+            return
+        if 'name' not in values:
+            self.warn("name not set in TypeInfo variable %s", self.name)
+            return
+        typename = values['name'].raw
+        if 'parent' not in values:
+            self.warn("parent not set in TypeInfo variable %s", self.name)
+            return
+        parent_typename = values['parent'].raw
+
+        instancetype = None
+        if 'instance_size' in values:
+            m = re.fullmatch(RE_SIZEOF, values['instance_size'].raw)
+            if m:
+                instancetype = m.group('sizeoftype')
+            else:
+                self.warn("can't extract instance type in TypeInfo variable %s", self.name)
+                self.warn("instance_size is set to: %r", values['instance_size'].raw)
+                return
+
+        classtype = None
+        if 'class_size' in values:
+            m = re.fullmatch(RE_SIZEOF, values['class_size'].raw)
+            if m:
+                classtype = m.group('sizeoftype')
+            else:
+                self.warn("can't extract class type in TypeInfo variable %s", self.name)
+                self.warn("class_size is set to: %r", values['class_size'].raw)
+                return
+
+        #NOTE: this will NOT work after declarations are converted
+        #      to OBJECT_DECLARE*
+
+        # Now, the challenge is to find out the right MODULE_OBJ_NAME for the
+        # type and for the parent type
+        instance_decl = find_type_declaration(self.allfiles, typename)
+        parent_decl = find_type_declaration(self.allfiles, parent_typename)
+
+        self.info("TypeInfo variable for %s is here", typename)
+        if instance_decl:
+            instance_decl.info("instance type declaration (%s) is here", instance_decl.match.group('uppercase'))
+        if parent_decl:
+            parent_decl.info("parent type declaration (%s) is here", parent_decl.match.group('uppercase'))
+
+        ok = True
+        if (instance_decl is None and (instancetype or classtype)):
+            self.warn("Can't find where type checkers for %s are declared.  We need them to validate sizes of %s", typename, self.name)
+            ok = False
+
+        if (instance_decl is not None
+            and 'instancetype' in instance_decl.match.groupdict()
+            and instancetype != instance_decl.group('instancetype')):
+            self.warn("type at instance_size is %r.  Should instance_size be set to sizeof(%s) ?",
+                      instancetype, instance_decl.group('instancetype'))
+            instance_decl.warn("Type checker declaration for %s is here", typename)
+            ok = False
+        if (instance_decl is not None
+            and 'classtype' in instance_decl.match.groupdict()
+            and classtype != instance_decl.group('classtype')):
+            self.warn("type at class_size is %r.  Should class_size be set to sizeof(%s) ?",
+                      classtype, instance_decl.group('classtype'))
+            instance_decl.warn("Type checker declaration for %s is here", typename)
+            ok = False
+
+        if not ok:
+            return
+
+        #if parent_decl is None:
+        #    self.warn("Can't find where parent type %s is declared", parent_typename)
+
+        self.info("%s can be patched!", self.name)
+        return
+        yield
+
+class RedundantTypeSizes(TypeInfoVar):
+    """Remove redundant instance_size/class_size from TypeInfo vars"""
+    def gen_patches(self) -> Iterable[Patch]:
+        values = self.initializers
+        if values is None:
+            return
+        if 'name' not in values:
+            self.warn("name not set in TypeInfo variable %s", self.name)
+            return
+        typename = values['name'].raw
+        if 'parent' not in values:
+            self.warn("parent not set in TypeInfo variable %s", self.name)
+            return
+        parent_typename = values['parent'].raw
+
+        if 'instance_size' not in values and 'class_size' not in values:
+            self.debug("no need to validate %s", self.name)
+            return
+
+        instance_decl = find_type_declaration(self.allfiles, typename)
+        if instance_decl:
+            self.debug("won't touch TypeInfo var that has type checkers")
+            return
+
+        parent = find_type_info(self.allfiles, parent_typename)
+        if not parent:
+            self.warn("Can't find TypeInfo for %s", parent_typename)
+            return
+
+        if 'instance_size' in values and parent.get_initializer_value('instance_size').raw != values['instance_size'].raw:
+            self.info("instance_size mismatch")
+            parent.info("parent type declared here")
+            return
+
+        if 'class_size' in values and parent.get_initializer_value('class_size').raw != values['class_size'].raw:
+            self.info("class_size mismatch")
+            parent.info("parent type declared here")
+            return
+
+        self.debug("will patch variable %s", self.name)
+
+        if 'instance_size' in values:
+            self.debug("deleting instance_size")
+            yield self.patch_field('instance_size', '')
+
+        if 'class_size' in values:
+            self.debug("deleting class_size")
+            yield self.patch_field('class_size', '')
+
+
+#class TypeInfoVarInitFuncs(TypeInfoVar):
+#    """TypeInfo variable
+#    Will create missing init functions
+#    """
+#    def gen_patches(self) -> Iterable[Patch]:
+#        values = self.initializers
+#        if values is None:
+#            self.warn("type not parsed completely: %s", self.name)
+#            return
+#
+#        macro = self.file.find_match(TypeInfoVar, self.name)
+#        if macro is None:
+#            self.warn("No TYPE_INFO macro for %s", self.name)
+#            return
+#
+#        ids = self.extract_identifiers()
+#        if ids is None:
+#            return
+#
+#        DBG("identifiers extracted: %r", ids)
+#        fields = set(values.keys())
+#        if ids.lowercase:
+#            if 'instance_init' not in fields:
+#                yield self.prepend(('static void %s_init(Object *obj)\n'
+#                                    '{\n'
+#                                    '}\n\n') % (ids.lowercase))
+#                yield self.append_field('instance_init', ids.lowercase+'_init')
+#
+#            if 'instance_finalize' not in fields:
+#                yield self.prepend(('static void %s_finalize(Object *obj)\n'
+#                                    '{\n'
+#                                    '}\n\n') % (ids.lowercase))
+#                yield self.append_field('instance_finalize', ids.lowercase+'_finalize')
+#
+#
+#            if 'class_init' not in fields:
+#                yield self.prepend(('static void %s_class_init(ObjectClass *oc, void *data)\n'
+#                                    '{\n'
+#                                    '}\n\n') % (ids.lowercase))
+#                yield self.append_field('class_init', ids.lowercase+'_class_init')
+
+class TypeInitMacro(FileMatch):
+    """type_init(...) macro use
+    Will be deleted if function is empty
+    """
+    regexp = S(r'^[ \t]*type_init\s*\(\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);?[ \t]*\n')
+    def gen_patches(self) -> Iterable[Patch]:
+        fn = self.file.find_match(StaticVoidFunction, self.name)
+        DBG("function for %s: %s", self.name, fn)
+        if fn and fn.body == '':
+            yield fn.make_patch('')
+            yield self.make_patch('')
+
+class StaticVoidFunction(FileMatch):
+    """simple static void function
+    (no replacement rules)
+    """
+    #NOTE: just like RE_FULL_STRUCT, this doesn't parse any of the body contents
+    #      of the function.  Tt will just look for "}" in the beginning of a line
+    regexp = S(r'static\s+void\s+', NAMED('name', RE_IDENTIFIER), r'\s*\(\s*void\s*\)\n',
+               r'{\n',
+               NAMED('body',
+                     # acceptable inside the function body:
+                     # - lines starting with space or tab
+                     # - empty lines
+                     # - preprocessor directives
+                     OR(r'[ \t][^\n]*\n',
+                        r'#[^\n]*\n',
+                        r'\n',
+                        repeat='*')),
+               r'}\n')
+
+    @property
+    def body(self) -> str:
+        return self.group('body')
+
+    def has_preprocessor_directive(self) -> bool:
+        return bool(re.search(r'^[ \t]*#', self.body, re.MULTILINE))
+
+class TypeRegisterCall(FileMatch):
+    """type_register_static() call
+    Will be replaced by TYPE_INFO() macro
+    """
+    regexp = S(r'^[ \t]*type_register_static\s*\(&\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);[ \t]*\n')
+
+    def function(self) -> Optional['StaticVoidFunction']:
+        """Return function containing this call"""
+        for m in self.file.matches_of_type(StaticVoidFunction):
+            if m.contains(self):
+                return m
+        return None
+
+    def gen_patches(self) -> Iterable[Patch]:
+        fn = self.function()
+        if fn is None:
+            self.warn("can't find function where type_register_static(&%s) is called", self.name)
+            return
+
+        #if fn.has_preprocessor_directive() and not self.file.force:
+        #    self.warn("function %s has preprocessor directives, this requires --force", fn.name)
+        #    return
+
+        type_init = self.file.find_match(TypeInitMacro, fn.name)
+        if type_init is None:
+            self.warn("can't find type_init(%s) line", fn.name)
+            return
+
+        var = self.file.find_match(TypeInfoVar, self.name)
+        if var is None:
+            self.warn("can't find TypeInfo var declaration for %s", self.name)
+            return
+
+        if not var.is_full():
+            self.warn("variable declaration %s wasn't parsed fully", var.name)
+            return
+
+        if fn.contains(var):
+            self.warn("TypeInfo %s variable is inside a function", self.name)
+            return
+
+        # delete type_register_static() call:
+        yield self.make_patch('')
+        # append TYPE_REGISTER(...) after variable declaration:
+        yield var.append(f'TYPE_INFO({self.name})\n')
+
+class TypeInfoMacro(FileMatch):
+    """TYPE_INFO macro usage"""
+    regexp = S(r'^[ \t]*TYPE_INFO\s*\(\s*', NAMED('name', RE_IDENTIFIER), r'\s*\)[ \t]*;?[ \t]*\n')
+
+def find_type_info(files: RegexpScanner, name: str) -> Optional[TypeInfoVar]:
+    ti = [ti for ti in files.matches_of_type(TypeInfoVar)
+            if ti.get_initializer_value('name').raw == name]
+    DBG("type info vars: %r", ti)
+    if len(ti) > 1:
+        DBG("multiple TypeInfo vars found for %s", name)
+        return None
+    if len(ti) == 0:
+        DBG("no TypeInfo var found for %s", name)
+        return None
+    return ti[0]
+
+class CreateClassStruct(DeclareInstanceChecker):
+    """Replace DECLARE_INSTANCE_CHECKER with OBJECT_DECLARE_SIMPLE_TYPE"""
+    def gen_patches(self) -> Iterable[Patch]:
+        typename = self.group('typename')
+        DBG("looking for TypeInfo variable for %s", typename)
+        var = find_type_info(self.allfiles, typename)
+        if var is None:
+            self.warn("no TypeInfo var found for %s", typename)
+            return
+        assert var.initializers
+        if 'class_size' in var.initializers:
+            self.warn("class size already set for TypeInfo %s", var.name)
+            return
+        classtype = self.group('instancetype')+'Class'
+        return
+        yield
+        #TODO: need to find out what's the parent class type...
+        #yield var.append_field('class_size', f'sizeof({classtype})')
+        #c = (f'OBJECT_DECLARE_SIMPLE_TYPE({instancetype}, {lowercase},\n'
+        #     f'                           MODULE_OBJ_NAME, ParentClassType)\n')
+        #yield self.make_patch(c)
+
+def type_infos(file: FileInfo) -> Iterable[TypeInfoVar]:
+    return file.matches_of_type(TypeInfoVar)
+
+def full_types(file: FileInfo) -> Iterable[TypeInfoVar]:
+    return [t for t in type_infos(file) if t.is_full()]
+
+def partial_types(file: FileInfo) -> Iterable[TypeInfoVar]:
+    return [t for t in type_infos(file) if not t.is_full()]
diff --git a/scripts/codeconverter/codeconverter/regexps.py b/scripts/codeconverter/codeconverter/regexps.py
new file mode 100644
index 0000000000..77993cc3b9
--- /dev/null
+++ b/scripts/codeconverter/codeconverter/regexps.py
@@ -0,0 +1,118 @@
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+"""Helpers for creation of regular expressions"""
+import re
+
+import logging
+logger = logging.getLogger(__name__)
+DBG = logger.debug
+INFO = logger.info
+WARN = logger.warning
+
+def S(*regexps) -> str:
+    """Just a shortcut to concatenate multiple regexps more easily"""
+    return ''.join(regexps)
+
+def P(*regexps, name=None, capture=False, repeat='') -> str:
+    """Just add parenthesis around regexp(s), with optional name or repeat suffix"""
+    s = S(*regexps)
+    if name:
+        return f'(?P<{name}>{s}){repeat}'
+    elif capture:
+        return f'({s}){repeat}'
+    else:
+        return f'(?:{s}){repeat}'
+
+def NAMED(name, *regexps) -> str:
+    """Make named group using <P<name>...) syntax
+
+    >>> NAMED('mygroup', 'xyz', 'abc')
+    '(?P<mygroup>xyzabc)'
+    """
+    return P(*regexps, name=name)
+
+def OR(*regexps, **kwargs) -> str:
+    """Build (a|b|c) regexp"""
+    return P('|'.join(regexps), **kwargs)
+
+def M(*regexps, n='*', name=None) -> str:
+    """Add repetition qualifier to regexp(s)
+
+    >>> M('a', 'b')
+    '(?:ab)*'
+    >>> M('a' , 'b', n='+')
+    '(?:ab)+'
+    >>> M('a' , 'b', n='{2,3}', name='name')
+    '(?P<name>(?:ab){2,3})'
+    """
+    r = P(*regexps, repeat=n)
+    if name:
+        r = NAMED(name, r)
+    return r
+
+# helper to make parenthesis optional around regexp
+OPTIONAL_PARS = lambda R: OR(S(r'\(\s*', R, r'\s*\)'), R)
+def test_optional_pars():
+    r = OPTIONAL_PARS('abc')+'$'
+    assert re.match(r, 'abc')
+    assert re.match(r, '(abc)')
+    assert not re.match(r, '(abcd)')
+    assert not re.match(r, '(abc')
+    assert not re.match(r, 'abc)')
+
+
+# this disables the MULTILINE flag, so it will match at the
+# beginning of the file:
+RE_FILE_BEGIN = r'(?-m:^)'
+
+# C primitives:
+
+SP = r'\s*'
+
+RE_COMMENT = r'//[^\n]*$|/\*([^*]|\*[^/])*\*/'
+RE_COMMENTS = M(RE_COMMENT + SP)
+
+RE_IDENTIFIER = r'[a-zA-Z_][a-zA-Z0-9_]*(?![a-zA-Z0-9])'
+RE_STRING = r'\"([^\"\\]|\\[a-z\"])*\"'
+RE_NUMBER = r'[0-9]+|0x[0-9a-fA-F]+'
+
+# space or escaped newlines:
+CPP_SPACE = OR(r'\s', r'\\\n', repeat='+')
+
+RE_PATH = '[a-zA-Z0-9/_.-]+'
+
+RE_INCLUDEPATH = OR(S(r'\"', RE_PATH, r'\"'),
+                    S(r'<', RE_PATH, r'>'))
+
+RE_INCLUDE = S(r'^[ \t]*#[ \t]*include[ \t]+', NAMED('includepath', RE_INCLUDEPATH), r'[ \t]*\n')
+RE_SIMPLEDEFINE = S(r'^[ \t]*#[ \t]*define[ \t]+', RE_IDENTIFIER, r'[ \t]*\n')
+
+RE_STRUCT_TYPE = S(r'struct\s+', RE_IDENTIFIER)
+RE_TYPE = OR(RE_IDENTIFIER, RE_STRUCT_TYPE)
+
+RE_MACRO_CONCAT = M(S(OR(RE_IDENTIFIER, RE_STRING), SP), n='{2,}')
+
+RE_SIMPLE_VALUE = OR(RE_IDENTIFIER, RE_STRING, RE_NUMBER)
+
+RE_FUN_CALL = S(RE_IDENTIFIER, r'\s*\(\s*', RE_SIMPLE_VALUE, r'\s*\)')
+RE_SIZEOF = S(r'sizeof\s*\(\s*', NAMED('sizeoftype', RE_TYPE), r'\s*\)')
+
+RE_ADDRESS = S(r'&\s*', RE_IDENTIFIER)
+
+RE_ARRAY_ITEM = S(r'{\s*', NAMED('arrayitem', M(RE_SIMPLE_VALUE, n='?')), r'\s*}\s*,?')
+RE_ARRAY_CAST = S(r'\(\s*', RE_IDENTIFIER, r'\s*\[\s*\]\)')
+RE_ARRAY_ITEMS = M(S(RE_ARRAY_ITEM, SP))
+RE_ARRAY = S(M(RE_ARRAY_CAST, n='?'), r'\s*{\s*',
+             NAMED('arrayitems', RE_ARRAY_ITEMS),
+             r'}')
+
+# NOTE: this covers a very small subset of valid expressions
+
+RE_EXPRESSION = OR(RE_SIZEOF, RE_FUN_CALL, RE_MACRO_CONCAT, RE_SIMPLE_VALUE,
+                   RE_ARRAY, RE_ADDRESS)
+
diff --git a/scripts/codeconverter/codeconverter/test_patching.py b/scripts/codeconverter/codeconverter/test_patching.py
new file mode 100644
index 0000000000..5998af81c9
--- /dev/null
+++ b/scripts/codeconverter/codeconverter/test_patching.py
@@ -0,0 +1,105 @@
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+from tempfile import NamedTemporaryFile
+from .patching import FileInfo, FileMatch, Patch, FileList
+from .regexps import *
+
+class BasicPattern(FileMatch):
+    regexp = '[abc]{3}'
+
+    @property
+    def name(self):
+        return self.group(0)
+
+    def replacement(self) -> str:
+        # replace match with the middle character repeated 5 times
+        return self.group(0)[1].upper()*5
+
+def test_pattern_patching():
+    of = NamedTemporaryFile('wt')
+    of.writelines(['one line\n',
+                  'this pattern will be patched: defbbahij\n',
+                  'third line\n',
+                  'another pattern: jihaabfed'])
+    of.flush()
+
+    files = FileList()
+    f = FileInfo(files, of.name)
+    f.load()
+    f.scan_for_matches()
+    matches = f.matches_of_type(BasicPattern)
+    assert len(matches) == 2
+    p2 = matches[1]
+
+    # manually add patch, to see if .append() works:
+    f.patches.append(p2.append('XXX'))
+
+    # apply all patches:
+    f.gen_patches()
+    patched = f.get_patched_content()
+    assert patched == ('one line\n'+
+                       'this pattern will be patched: defBBBBBhij\n'+
+                       'third line\n'+
+                       'another pattern: jihAAAAAXXXfed')
+
+class Function(FileMatch):
+    regexp = S(r'BEGIN\s+', NAMED('name', RE_IDENTIFIER), r'\n',
+               r'(.*\n)*?END\n')
+
+class Statement(FileMatch):
+    regexp = S(r'^\s*', NAMED('name', RE_IDENTIFIER), r'\(\)\n')
+
+def test_container_match():
+    of = NamedTemporaryFile('wt')
+    of.writelines(['statement1()\n',
+                   'statement2()\n',
+                   'BEGIN function1\n',
+                   '  statement3()\n',
+                   '  statement4()\n',
+                   'END\n',
+                   'BEGIN function2\n',
+                   '  statement5()\n',
+                   '  statement6()\n',
+                   'END\n',
+                   'statement7()\n'])
+    of.flush()
+
+    files = FileList()
+    f = FileInfo(files, of.name)
+    f.load()
+    assert len(f.matches_of_type(Function)) == 2
+    print(' '.join(m.name for m in f.matches_of_type(Statement)))
+    assert len(f.matches_of_type(Statement)) == 7
+
+    f1 = f.find_match(Function, 'function1')
+    f2 = f.find_match(Function, 'function2')
+    st1 = f.find_match(Statement, 'statement1')
+    st2 = f.find_match(Statement, 'statement2')
+    st3 = f.find_match(Statement, 'statement3')
+    st4 = f.find_match(Statement, 'statement4')
+    st5 = f.find_match(Statement, 'statement5')
+    st6 = f.find_match(Statement, 'statement6')
+    st7 = f.find_match(Statement, 'statement7')
+
+    assert not f1.contains(st1)
+    assert not f1.contains(st2)
+    assert not f1.contains(st2)
+    assert f1.contains(st3)
+    assert f1.contains(st4)
+    assert not f1.contains(st5)
+    assert not f1.contains(st6)
+    assert not f1.contains(st7)
+
+    assert not f2.contains(st1)
+    assert not f2.contains(st2)
+    assert not f2.contains(st2)
+    assert not f2.contains(st3)
+    assert not f2.contains(st4)
+    assert f2.contains(st5)
+    assert f2.contains(st6)
+    assert not f2.contains(st7)
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
new file mode 100644
index 0000000000..9b84d689a6
--- /dev/null
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -0,0 +1,282 @@
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+from .regexps import *
+from .qom_macros import *
+from .qom_type_info import *
+
+def test_res():
+    def fullmatch(regexp, s):
+        return re.fullmatch(regexp, s, re.MULTILINE)
+
+    assert fullmatch(RE_IDENTIFIER, 'sizeof')
+    assert fullmatch(RE_IDENTIFIER, 'X86CPU')
+    assert fullmatch(RE_FUN_CALL, 'sizeof(X86CPU)')
+    assert fullmatch(RE_IDENTIFIER, 'X86_CPU_TYPE_NAME')
+    assert fullmatch(RE_SIMPLE_VALUE, '"base"')
+    print(RE_FUN_CALL)
+    assert fullmatch(RE_FUN_CALL, 'X86_CPU_TYPE_NAME("base")')
+    print(RE_TI_FIELD_INIT)
+    assert fullmatch(RE_TI_FIELD_INIT, '.name = X86_CPU_TYPE_NAME("base"),\n')
+
+
+    assert fullmatch(RE_MACRO_CONCAT, 'TYPE_ASPEED_GPIO "-ast2600"')
+    assert fullmatch(RE_EXPRESSION, 'TYPE_ASPEED_GPIO "-ast2600"')
+
+    print(RE_MACRO_DEFINE)
+    assert re.search(RE_MACRO_DEFINE, r'''
+    #define OFFSET_CHECK(c)                     \
+    do {                                        \
+        if (!(c)) {                             \
+            goto bad_offset;                    \
+        }                                       \
+    } while (0)
+    ''', re.MULTILINE)
+
+    print(RE_CHECK_MACRO)
+    print(CPP_SPACE)
+    assert not re.match(RE_CHECK_MACRO, r'''
+    #define OFFSET_CHECK(c)                     \
+    do {                                        \
+        if (!(c)) {                             \
+            goto bad_offset;                    \
+        }                                       \
+    } while (0)''', re.MULTILINE)
+
+    print(RE_CHECK_MACRO)
+    assert fullmatch(RE_CHECK_MACRO, r'''#define PCI_DEVICE(obj) \
+                     OBJECT_CHECK(PCIDevice, (obj), TYPE_PCI_DEVICE)
+''')
+    assert fullmatch(RE_CHECK_MACRO, r'''#define COLLIE_MACHINE(obj) \
+                     OBJECT_CHECK(CollieMachineState, obj, TYPE_COLLIE_MACHINE)
+''')
+
+    print(RE_TYPEINFO_START)
+    assert re.search(RE_TYPEINFO_START, r'''
+    cc->open = qmp_chardev_open_file;
+}
+
+static const TypeInfo char_file_type_info = {
+    .name = TYPE_CHARDEV_FILE,
+#ifdef _WIN32
+    .parent = TYPE_CHARDEV_WIN,
+''', re.MULTILINE)
+    assert re.search(RE_TYPEINFO_START, r'''
+        TypeInfo ti = {
+            .name = armsse_variants[i].name,
+            .parent = TYPE_ARMSSE,
+            .class_init = armsse_class_init,
+            .class_data = (void *)&armsse_variants[i],
+        };''', re.MULTILINE)
+
+    print(RE_ARRAY_ITEM)
+    assert fullmatch(RE_ARRAY_ITEM, '{ TYPE_HOTPLUG_HANDLER },')
+    assert fullmatch(RE_ARRAY_ITEM, '{ TYPE_ACPI_DEVICE_IF },')
+    assert fullmatch(RE_ARRAY_ITEM, '{ }')
+    assert fullmatch(RE_ARRAY_CAST, '(InterfaceInfo[])')
+    assert fullmatch(RE_ARRAY, '''(InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { TYPE_ACPI_DEVICE_IF },
+            { }
+    }''')
+    print(RE_COMMENT)
+    assert fullmatch(RE_COMMENT, r'''/* multi-line
+                                      * comment
+                                      */''')
+
+    print(RE_TI_FIELDS)
+    assert fullmatch(RE_TI_FIELDS,
+    r'''/* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
+        .parent = TYPE_DEVICE,
+''')
+    assert fullmatch(RE_TI_FIELDS, r'''.name = TYPE_TPM_CRB,
+        /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(CRBState),
+        .class_init  = tpm_crb_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_TPM_IF },
+            { }
+        }
+''')
+    assert fullmatch(RE_TI_FIELDS + SP + RE_COMMENTS,
+        r'''.name = TYPE_PALM_MISC_GPIO,
+            .parent = TYPE_SYS_BUS_DEVICE,
+            .instance_size = sizeof(PalmMiscGPIOState),
+            .instance_init = palm_misc_gpio_init,
+            /*
+             * No class init required: device has no internal state so does not
+             * need to set up reset or vmstate, and has no realize method.
+             */''')
+
+    print(RE_TYPEINFO_DEF)
+    test_empty = 'static const TypeInfo x86_base_cpu_type_info = {\n'+\
+                 '};\n';
+    assert fullmatch(RE_TYPEINFO_DEF, test_empty)
+
+    test_simple = r'''
+    static const TypeInfo x86_base_cpu_type_info = {
+        .name = X86_CPU_TYPE_NAME("base"),
+        .parent = TYPE_X86_CPU,
+        .class_init = x86_cpu_base_class_init,
+    };
+    '''
+    assert re.search(RE_TYPEINFO_DEF, test_simple, re.MULTILINE)
+
+    test_interfaces = r'''
+    static const TypeInfo acpi_ged_info = {
+        .name          = TYPE_ACPI_GED,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AcpiGedState),
+        .instance_init  = acpi_ged_initfn,
+        .class_init    = acpi_ged_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { TYPE_ACPI_DEVICE_IF },
+            { }
+        }
+    };
+    '''
+    assert re.search(RE_TYPEINFO_DEF, test_interfaces, re.MULTILINE)
+
+    test_comments = r'''
+    static const TypeInfo palm_misc_gpio_info = {
+        .name = TYPE_PALM_MISC_GPIO,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(PalmMiscGPIOState),
+        .instance_init = palm_misc_gpio_init,
+        /*
+         * No class init required: device has no internal state so does not
+         * need to set up reset or vmstate, and has no realize method.
+         */
+    };
+    '''
+    assert re.search(RE_TYPEINFO_DEF, test_comments, re.MULTILINE)
+
+    test_comments = r'''
+    static const TypeInfo tpm_crb_info = {
+        .name = TYPE_TPM_CRB,
+        /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(CRBState),
+        .class_init  = tpm_crb_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_TPM_IF },
+            { }
+        }
+    };
+    '''
+    assert re.search(RE_TYPEINFO_DEF, test_comments, re.MULTILINE)
+
+def test_struct_re():
+    print('---')
+    print(RE_STRUCT_TYPEDEF)
+    assert re.search(RE_STRUCT_TYPEDEF, r'''
+typedef struct TCGState {
+    AccelState parent_obj;
+
+    bool mttcg_enabled;
+    unsigned long tb_size;
+} TCGState;
+''', re.MULTILINE)
+
+    assert re.search(RE_STRUCT_TYPEDEF, r'''
+typedef struct {
+    ISADevice parent_obj;
+
+    QEMUSoundCard card;
+    uint32_t freq;
+    uint32_t port;
+    int ticking[2];
+    int enabled;
+    int active;
+    int bufpos;
+#ifdef DEBUG
+    int64_t exp[2];
+#endif
+    int16_t *mixbuf;
+    uint64_t dexp[2];
+    SWVoiceOut *voice;
+    int left, pos, samples;
+    QEMUAudioTimeStamp ats;
+    FM_OPL *opl;
+    PortioList port_list;
+} AdlibState;
+''', re.MULTILINE)
+
+    false_positive = r'''
+typedef struct dma_pagetable_entry {
+    int32_t frame;
+    int32_t owner;
+} A B C D E;
+struct foo {
+    int x;
+} some_variable;
+'''
+    assert not re.search(RE_STRUCT_TYPEDEF, false_positive, re.MULTILINE)
+
+def test_initial_includes():
+    print(InitialIncludes.regexp)
+    c = '''
+#ifndef HW_FLASH_H
+#define HW_FLASH_H
+
+/* NOR flash devices */
+
+#include "qom/object.h"
+#include "exec/hwaddr.h"
+
+/* pflash_cfi01.c */
+'''
+    print(repr(list(m.groupdict() for m in re.finditer(InitialIncludes.regexp, c, re.MULTILINE))))
+    m = re.match(InitialIncludes.regexp, c, re.MULTILINE)
+    assert m
+    print(repr(m.group(0)))
+    assert m.group(0).endswith('#include "exec/hwaddr.h"\n')
+
+    c = '''#ifndef QEMU_VIRTIO_9P_H
+#define QEMU_VIRTIO_9P_H
+
+#include "standard-headers/linux/virtio_9p.h"
+#include "hw/virtio/virtio.h"
+#include "9p.h"
+
+
+'''
+    print(repr(list(m.groupdict() for m in re.finditer(InitialIncludes.regexp, c, re.MULTILINE))))
+    m = re.match(InitialIncludes.regexp, c, re.MULTILINE)
+    assert m
+    print(repr(m.group(0)))
+    assert m.group(0).endswith('#include "9p.h"\n')
+
+    c = '''#include "qom/object.h"
+/*
+ * QEMU ES1370 emulation
+...
+ */
+
+/* #define DEBUG_ES1370 */
+/* #define VERBOSE_ES1370 */
+#define SILENT_ES1370
+
+#include "qemu/osdep.h"
+#include "hw/audio/soundhw.h"
+#include "audio/audio.h"
+#include "hw/pci/pci.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "sysemu/dma.h"
+
+/* Missing stuff:
+   SCTRL_P[12](END|ST)INC
+'''
+    print(repr(list(m.groupdict() for m in re.finditer(InitialIncludes.regexp, c, re.MULTILINE))))
+    m = re.match(InitialIncludes.regexp, c, re.MULTILINE)
+    assert m
+    print(repr(m.group(0)))
+    assert m.group(0).endswith('#include "sysemu/dma.h"\n')
+
diff --git a/scripts/codeconverter/codeconverter/utils.py b/scripts/codeconverter/codeconverter/utils.py
new file mode 100644
index 0000000000..760ab7eecd
--- /dev/null
+++ b/scripts/codeconverter/codeconverter/utils.py
@@ -0,0 +1,72 @@
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+from typing import *
+
+import logging
+logger = logging.getLogger(__name__)
+DBG = logger.debug
+INFO = logger.info
+WARN = logger.warning
+
+T = TypeVar('T')
+def opt_compare(a: T, b: T) -> bool:
+    """Compare two values, ignoring mismatches if one of them is None"""
+    return (a is None) or (b is None) or (a == b)
+
+def merge(a: T, b: T) -> T:
+    """Merge two values if they matched using opt_compare()"""
+    assert opt_compare(a, b)
+    if a is None:
+        return b
+    else:
+        return a
+
+def test_comp_merge():
+    assert opt_compare(None, 1) == True
+    assert opt_compare(2, None) == True
+    assert opt_compare(1, 1) == True
+    assert opt_compare(1, 2) == False
+
+    assert merge(None, None) is None
+    assert merge(None, 10) == 10
+    assert merge(10, None) == 10
+    assert merge(10, 10) == 10
+
+
+LineNumber = NewType('LineNumber', int)
+ColumnNumber = NewType('ColumnNumber', int)
+class LineAndColumn(NamedTuple):
+    line: int
+    col: int
+
+    def __str__(self):
+        return '%d:%d' % (self.line, self.col)
+
+def line_col(s, position: int) -> LineAndColumn:
+    """Return line and column for a char position in string
+
+    Character position starts in 0, but lines and columns start in 1.
+    """
+    before = s[:position]
+    lines = before.split('\n')
+    line = len(lines)
+    col = len(lines[-1]) + 1
+    return LineAndColumn(line, col)
+
+def test_line_col():
+    assert line_col('abc\ndefg\nhijkl', 0) == (1, 1)
+    assert line_col('abc\ndefg\nhijkl', 2) == (1, 3)
+    assert line_col('abc\ndefg\nhijkl', 3) == (1, 4)
+    assert line_col('abc\ndefg\nhijkl', 4) == (2, 1)
+    assert line_col('abc\ndefg\nhijkl', 10) == (3, 2)
+
+def not_optional(arg: Optional[T]) -> T:
+    assert arg is not None
+    return arg
+
+__all__ = ['not_optional', 'opt_compare', 'merge', 'line_col', 'LineAndColumn']
\ No newline at end of file
diff --git a/scripts/codeconverter/converter.py b/scripts/codeconverter/converter.py
new file mode 100755
index 0000000000..ebaf9b57ce
--- /dev/null
+++ b/scripts/codeconverter/converter.py
@@ -0,0 +1,123 @@
+#!/usr/bin/env python3
+# QEMU library
+#
+# Copyright (C) 2020 Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+#
+import sys
+import argparse
+import os
+import os.path
+import re
+from typing import *
+
+from codeconverter.patching import FileInfo, match_class_dict, FileList
+import codeconverter.qom_macros
+from codeconverter.qom_type_info import TI_FIELDS, type_infos, TypeInfoVar
+
+import logging
+logger = logging.getLogger(__name__)
+DBG = logger.debug
+INFO = logger.info
+WARN = logger.warning
+
+def process_all_files(parser: argparse.ArgumentParser, args: argparse.Namespace) -> None:
+    DBG("filenames: %r", args.filenames)
+
+    files = FileList()
+    files.extend(FileInfo(files, fn, args.force) for fn in args.filenames)
+    for f in files:
+        DBG('opening %s', f.filename)
+        f.load()
+
+    if args.table:
+        fields = ['filename', 'variable_name'] + TI_FIELDS
+        print('\t'.join(fields))
+        for f in files:
+            for t in f.matches_of_type(TypeInfoVar):
+                assert isinstance(t, TypeInfoVar)
+                values = [f.filename, t.name] + \
+                         [t.get_initializer_value(f).raw
+                          for f in TI_FIELDS]
+                DBG('values: %r', values)
+                assert all('\t' not in v for v in values)
+                values = [v.replace('\n', ' ').replace('"', '') for v in values]
+                print('\t'.join(values))
+        return
+
+    match_classes = match_class_dict()
+    if not args.patterns:
+        parser.error("--pattern is required")
+
+    classes = [p for arg in args.patterns
+                for p in re.split(r'[\s,]', arg)]
+    for c in classes:
+        if c not in match_classes:
+            print("Invalid pattern name: %s" % (c), file=sys.stderr)
+            print("Valid patterns:", file=sys.stderr)
+            print(PATTERN_HELP, file=sys.stderr)
+            sys.exit(1)
+
+    DBG("classes: %r", classes)
+    for f in files:
+        DBG("patching contents of %s", f.filename)
+        f.patch_content(max_passes=args.passes, class_names=classes)
+
+    for f in files:
+        #alltypes.extend(f.type_infos)
+        #full_types.extend(f.full_types())
+
+        if not args.dry_run:
+            if args.inplace:
+                f.patch_inplace()
+            if args.diff:
+                f.show_diff()
+            if not args.diff and not args.inplace:
+                f.write_to_file(sys.stdout)
+                sys.stdout.flush()
+
+
+PATTERN_HELP = ('\n'.join("  %s: %s" % (n, str(c.__doc__).strip())
+                for (n,c) in sorted(match_class_dict().items())
+                if c.has_replacement_rule()))
+
+def main() -> None:
+    p = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter)
+    p.add_argument('filenames', nargs='+')
+    p.add_argument('--passes', type=int, default=1,
+                   help="Number of passes (0 means unlimited)")
+    p.add_argument('--pattern', required=True, action='append',
+                   default=[], dest='patterns',
+                   help="Pattern to scan for")
+    p.add_argument('--inplace', '-i', action='store_true',
+                   help="Patch file in place")
+    p.add_argument('--dry-run', action='store_true',
+                   help="Don't patch files or print patching results")
+    p.add_argument('--force', '-f', action='store_true',
+                   help="Perform changes even if not completely safe")
+    p.add_argument('--diff', action='store_true',
+                   help="Print diff output on stdout")
+    p.add_argument('--debug', '-d', action='store_true',
+                   help="Enable debugging")
+    p.add_argument('--verbose', '-v', action='store_true',
+                   help="Verbose logging on stderr")
+    p.add_argument('--table', action='store_true',
+                   help="Print CSV table of type information")
+    p.add_argument_group("Valid pattern names",
+                         PATTERN_HELP)
+    args = p.parse_args()
+
+    loglevel = (logging.DEBUG if args.debug
+             else logging.INFO if args.verbose
+             else logging.WARN)
+    logging.basicConfig(format='%(levelname)s: %(message)s', level=loglevel)
+    DBG("args: %r", args)
+    process_all_files(p, args)
+
+if __name__ == '__main__':
+    main()
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index b233da2a73..752d0304ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2423,6 +2423,11 @@ F: tests/check-qom-interface.c
 F: tests/check-qom-proplist.c
 F: tests/test-qdev-global-props.c
 
+QOM boilerplate conversion script
+M: Eduardo Habkost <ehabkost@redhat.com>
+S: Maintained
+F: scripts/codeconverter/
+
 QMP
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
-- 
2.26.2


